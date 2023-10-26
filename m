Return-Path: <netdev+bounces-44484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 986207D8426
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FCE1C20E96
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA5A2E411;
	Thu, 26 Oct 2023 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="jcx72dBM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAE62E405
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:01:53 +0000 (UTC)
X-Greylist: delayed 2593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 07:01:49 PDT
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E8F1A2
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 07:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=fRkFsz1VlOEW5rFG9taE2bwY7cLjyhOQP6DO6wVaLOs=; b=jcx72dBMgetqtuU9SWncEF5Fyj
	ZU735Xh9LToJXFg2iX3SW8f6cV74WXtOYHMIzzFea+1/mA1VJvN7n1jmOamiySSV5gyhPv+mgNxm0
	w0FfRCE1sj1aROkiTIMJDOl9rNC3Y4uwoLFDTAQCE2Xm3rNsNUX9SANEf2gf/XdmaWFsnDI7g44go
	hcKpYO5OeALjB0rJU1VU8ciRDMmagb+n08sVgwPPlrrdO20KgpEazICdeWLvhSzjlTr/ydj4MWfwO
	hEDZFqO8idnYCpXV9UXPW9X/eY419U7Hr421oBr/yVWoKTAs/FzHxSMXEArwjmxwPH0iofGtjlnbt
	35sVvZiw7IDT8PBcONxbJftRAbZiwZ13xWizDdZL2ORro11FMmzSSMndxib88AO5tA0A5JQJs6WD6
	6ber8sRTD5s2GAQBIBa2K3ewYiOyB7Ctrp1owZ9XFHusHHzbZ+ellBD0/6sbz91eJyrLl/vxcApzO
	+kBON3gVKBbi0eOgs6gJHo6H1U8Hz+XWEe/CH831F4tNHg4j6llotxOo4HZLqIGbZFLaihZKC18fh
	y9q67KEHqNxbxaD0Qxgr/Nl8NTexgpQUpvMGdt5goebm0MRzZRmq9xLF7YkyYfUGraxHzrLuS7q4l
	hbCoUDWQTp75bDwsqqHvQ/9l7sdiiC2krgkwtIz/k=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Hangyu Hua <hbh25y@gmail.com>, asmadeus@codewreck.org
Cc: ericvh@kernel.org, lucho@ionkov.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jvrao@linux.vnet.ibm.com, v9fs@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: 9p: fix possible memory leak in p9_check_errors()
Date: Thu, 26 Oct 2023 15:18:16 +0200
Message-ID: <2383398.41Bra3A7bo@silver>
In-Reply-To: <ZTpTU8-1zn_P22QX@codewreck.org>
References:
 <20231026092351.30572-1-hbh25y@gmail.com> <ZTpTU8-1zn_P22QX@codewreck.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, October 26, 2023 1:53:55 PM CEST asmadeus@codewreck.org wrote:
> 
> Hangyu Hua wrote on Thu, Oct 26, 2023 at 05:23:51PM +0800:
> > When p9pdu_readf is called with "s?d" attribute, it allocates a pointer
> > that will store a string. But when p9pdu_readf() fails while handling "d"
> > then this pointer will not be freed in p9_check_errors.
> 
> Right, that sounds correct to me.
> 
> Out of curiosity how did you notice this? The leak shouldn't happen with
> any valid server.
> 
> This cannot break anything so I'll push this to -next tomorrow and
> submit to Linus next week
> 
> > Fixes: ca41bb3e21d7 ("[net/9p] Handle Zero Copy TREAD/RERROR case in !dotl case.")
> 
> This commit moves this code a bit, but the p9pdu_readf call predates
> it -- in this case the Fixes tag is probably not useful; this affects
> all maintained kernels.

Looks like it exists since introduction of p9_check_errors(), therefore:

Fixes: 51a87c552dfd ("9p: rework client code to use new protocol support functions")

> > Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> > ---
> >  net/9p/client.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/9p/client.c b/net/9p/client.c
> > index 86bbc7147fc1..6c7cd765b714 100644
> > --- a/net/9p/client.c
> > +++ b/net/9p/client.c
> > @@ -540,12 +540,15 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
> >  		return 0;
> >  
> >  	if (!p9_is_proto_dotl(c)) {
> > -		char *ename;
> > +		char *ename = NULL;
> >  
> >  		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
> >  				  &ename, &ecode);
> > -		if (err)
> > +		if (err) {
> > +			if (ename != NULL)
> > +				kfree(ename);
> 
> Don't check for NULL before kfree - kfree does it.
> If that's the only remark you get I can fix it when applying the commit
> on my side.

With those two remarks addressed:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> 
> 
> >  			goto out_err;
> > +		}
> >  
> >  		if (p9_is_proto_dotu(c) && ecode < 512)
> >  			err = -ecode;
> 
> 



