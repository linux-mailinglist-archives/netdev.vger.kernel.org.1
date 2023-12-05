Return-Path: <netdev+bounces-53945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBA4805582
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40ED41C20BDB
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA305C8FD;
	Tue,  5 Dec 2023 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="aasXfPbL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E23E1A1;
	Tue,  5 Dec 2023 05:09:52 -0800 (PST)
Received: from localhost (unknown [46.242.8.170])
	by mail.ispras.ru (Postfix) with ESMTPSA id 78D6040F1DE8;
	Tue,  5 Dec 2023 13:09:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 78D6040F1DE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1701781790;
	bh=oi7izhC+Mi04W0sOK3v7n9Fcp0jij5UOcHWWve901kU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aasXfPbLphcBf9KA8ojM/DM9ha1+/mluqBQL/qqzuL9/RVIdk0uA4qCb/Z4wlgeyD
	 hZ+3c0O2+B6u0EsgOjjbHt1iPUeXxBUU/gs1L0TEZIgcT7RaDf2UaEudV8poiQaNU+
	 A2w6h4DG/lPR8kvy374H9Ekt725zcsSviPeVcGhU=
Date: Tue, 5 Dec 2023 16:09:49 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Eric Van Hensbergen <ericvh@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, v9fs@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] net: 9p: avoid freeing uninit memory in p9pdu_vreadf
Message-ID: <9f21f00b-0806-4811-8d0a-9b6175eaedeb-pchelkin@ispras.ru>
References: <20231205091952.24754-1-pchelkin@ispras.ru>
 <1741521.OAD31uVnNo@silver>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741521.OAD31uVnNo@silver>

On 23/12/05 01:29PM, Christian Schoenebeck wrote:
> On Tuesday, December 5, 2023 10:19:50 AM CET Fedor Pchelkin wrote:
> > If an error occurs while processing an array of strings in p9pdu_vreadf
> > then uninitialized members of *wnames array are freed.
> > 
> > Fix this by iterating over only lower indices of the array. Also handle
> > possible uninit *wnames usage if first p9pdu_readf() call inside 'T' case
> > fails.
> > 
> > Found by Linux Verification Center (linuxtesting.org).
> > 
> > Fixes: ace51c4dd2f9 ("9p: add new protocol support code")
> > Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> > ---
> > v2: I've missed that *wnames can also be left uninitialized. Please
> > ignore the patch v1. As an answer to Dominique's comment: my
> > organization marks this statement in all commits.
> > 
> >  net/9p/protocol.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/9p/protocol.c b/net/9p/protocol.c
> > index 4e3a2a1ffcb3..043b621f8b84 100644
> > --- a/net/9p/protocol.c
> > +++ b/net/9p/protocol.c
> > @@ -393,6 +393,8 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
> >  		case 'T':{
> >  				uint16_t *nwname = va_arg(ap, uint16_t *);
> >  				char ***wnames = va_arg(ap, char ***);
> > +				int i;
> > +				*wnames = NULL;
> 
> Consider also initializing `int i = 0;` here. Because ...
> 

The hassle with indices in this code can be eliminated with using
kcalloc() instead of kmalloc_array(). It would initialize all the members
to zero and later we can use the fact that kfree() is a no-op for NULL
args and iterate over all the elements - this trick is ubiquitous in
kernel AFAIK.

But when trying to do such kind of changes, I wonder whether it would
impact performance (I'm not able to test this fully) or related issues as
for some reason an unsafe kmalloc_array() was originally used.

If you have no objections, then I'll better prepare a new patch with
this in mind. That will make the code less prone to potential errors in
future.

> >  
> >  				errcode = p9pdu_readf(pdu, proto_version,
> >  								"w", nwname);
> > @@ -406,8 +408,6 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
> >  				}
> >  
> >  				if (!errcode) {
> > -					int i;
> > -
> >  					for (i = 0; i < *nwname; i++) {
> 
> ... this block that initializes `i` is conditional. I mean it does work right
> now as-is, because ...
> 
> >  						errcode =
> >  						    p9pdu_readf(pdu,
> > @@ -421,13 +421,11 @@ p9pdu_vreadf(struct p9_fcall *pdu, int proto_version, const char *fmt,
> >  
> >  				if (errcode) {
> >  					if (*wnames) {
> > -						int i;
> > -
> > -						for (i = 0; i < *nwname; i++)
> > +						while (--i >= 0)
> >  							kfree((*wnames)[i]);
> > +						kfree(*wnames);
> > +						*wnames = NULL;
> >  					}
> 
> ... this is wrapped into `if (*wnames) {` and you initialized *wnames with
> NULL, but it just feels like a potential future trap somehow.
> 
> Anyway, at least it looks like correct behaviour (ATM), so:
> 
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> 
> > -					kfree(*wnames);
> > -					*wnames = NULL;
> >  				}
> >  			}
> >  			break;
> > 
> 
> 

