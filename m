Return-Path: <netdev+bounces-272268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPqxAFWxxWlrAwUAu9opvQ
	(envelope-from <netdev+bounces-272268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:21:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9447033C4CE
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB377304EF50
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3569D3264D7;
	Thu, 26 Mar 2026 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMesgFlz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287B730C632
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563497; cv=none; b=j2+Q9+Lac27evvzopkCe2zfMWu416Xxj9RfrcOlTpp8AX4wNQ0p5V2IZP8AxNil45AK3v089GYuvUDc8dg2ynpWAceT1eQY19NrVLOF924IfjIY2ZgjnZMosyYxiGk2FNI1v8Iup58hfgqr1T+NCEeSE1zFviGbvZdxT8jNkORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563497; c=relaxed/simple;
	bh=qpFX/JTbGIwdSC3Z3k4i+PdijUgT1IlDDER/t+YpzgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4rwduBxvLoHtFIrRwEGdjA/H/iina+PSkoPi1aEwuCTAbUiMdYdZSwpz+wWakP/zbeJSyTLzQ80X4rqCV9Nc4SjdHLQrE8uDCD9uwHA/ykrCIkLh2qjvyxbbi/nBNH1LaQI8iC79Y7bP6fv/6IxDRBiXTqNMrhFv1hWqz3lnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMesgFlz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486fb112c09so15001995e9.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774563492; x=1775168292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Nacxvr2ELo/XQwaZt97OI3oFNXHowVhMcBzyb+a0KA=;
        b=eMesgFlzRFNrh6qF8YWhQ9hkDLYv7gWgyBWEhVLiWJOLGGpYuTOVUlDzR4NXzywIMp
         0AfARdlbT1RHFfMu2b88Bm0GUjshZKnCXz1rJ1uh+IRFsdCu31Wrl5CpWHCmGkU4SoBn
         E4frD3LZCFcUqs6mhCFQKekBvZEyTy4vMNFT/SdTc3zM6Joh0L4DUoC3y4TpvTXuUO1X
         j334/otE8uA+lXgk9iwgYy0l7Yd7nU4pUZbAUSoBeCw+7eV2sjftR+48YHmYPMKbhMI5
         IgQWAuzZUGgB3A+tVb0R7hqkljRPk8I87I0XyVgZFkj++jHNb4LSy5rLZi5GDNkTcILy
         Tn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563492; x=1775168292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Nacxvr2ELo/XQwaZt97OI3oFNXHowVhMcBzyb+a0KA=;
        b=sOoHc7q8mQpm4fp8kaNK/CM6cVlshbhWY1V08gR7083oNdKIsFTEExBtb4Pbo2C/Tq
         ZMPXBdvxY6sLs2CqCD2lQhiVeiclg02I//MB2gSDz2LkAfSbqvZqWrpLTVe554aAB9nZ
         6HTW30/v1mqwZGqS659xzTNAXf5fDruY3BAvxRSsuaMxuicwdODNpfaOewQIvy8hsucx
         XXE5nMc1rMYNpOD8ypMSV1DiMATkMbPMktQchQkiHLaCv8HN+r727jZ/T8OiAKuutThv
         M6aQk5Aoo3hEVWclOEaZa3UvaXAVlcMVmTmNOzgaXulnb4NpSBciuxWVF61htQHtK1c0
         OHkg==
X-Forwarded-Encrypted: i=1; AJvYcCW7QQW1q5Atcj5t+xS27iItCP/w6BAkZ3caiiAYZi0SanSGQIBxr6w/T9jP92ZJ+PShLyy3IPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1tlxwRX67E6gymuuHvT21ewsgdBPum4XDnFoFzJw4Glfd6KM4
	OW5XNd7Vy68kKJKr3iyhkel3CZC5W3nbIj4ipMDEvJmxR70Ri5pyun5Q
X-Gm-Gg: ATEYQzzeMYhiFMT9WxOnqw81mdsAikowER1yuUbWQwZrva/D3HyE5Sxhrd/lWJSNDUP
	hE3orkGBN2HLa1mILK9dS1Mcn6rqR6b6adS8NLSxekBC4SKvh+3ORg0/n3ROXTdpi7XQnhxZZ2V
	MoQ3CsbmER+yskImUNaS5oahlqhVUsYwU0nrkLZu59QVGbJUBEclSLGxRbB1zbDjw4k+xckyBpS
	uydiLj69TurlbYS1LyCR1zSvMR2+Qyd7jlMRJtIfdpAfwwjBdgw3l5QfiGp8u7oTiK5e8rji+hL
	Zm8BajchL8UXZbHiFgVneyN+2cqTbZF8RPeQBmglRXiBUY6dKq3oujUrGV70OTyK7dXIB+9jSbu
	zC6cccCYCg6D+6nrG4/eXl77YhFXHXCfoByp2Bl9LH+ERHD9/coFxUT4P0PGXrr2yIhVgm3U+a/
	K6QHJfhb0jOQjxgXdAPBDHbKZEO4ae8JeULxab9mv1vg7uZhO+OmqVBbtT/oWJESNi
X-Received: by 2002:a05:600c:5290:b0:486:fcdf:c065 with SMTP id 5b1f17b1804b1-4872808d317mr4858335e9.27.1774563492316;
        Thu, 26 Mar 2026 15:18:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c78bc2sm55136515e9.5.2026.03.26.15.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:18:11 -0700 (PDT)
Date: Thu, 26 Mar 2026 22:18:09 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Petr
 Mladek <pmladek@suse.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] netfilter: nf_conntrack_h323: Correct indentation
 when H323_TRACE defined
Message-ID: <20260326221809.0b99df3f@pumpkin>
In-Reply-To: <acWWBxmPd_BNqUHF@chamomile>
References: <20260326201819.3900-1-david.laight.linux@gmail.com>
	<acWWBxmPd_BNqUHF@chamomile>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272268-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email]
X-Rspamd-Queue-Id: 9447033C4CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 21:24:39 +0100
Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> Hi David,
> 
> On Thu, Mar 26, 2026 at 08:18:19PM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > The trace lines are indented using PRINT("%*.s", xx, " ").
> > Userspace will treat this as "%*.0s" and will output no characters
> > when 'xx' is zero, the kernel treats it as "%*s" and will output
> > a single ' ' - which is probably what is intended.
> > 
> > Change all the formats to "%*s" removing the default precision.
> > This gives a single space indent when level is zero.  
> 
> Do you have a setup using this helper? Or you just found this via
> visual inspection?

Found with grep looking for places which might be affected by 'fixing'
the kernel printf code to be POSIX compliant.

	David

> 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> >  net/netfilter/nf_conntrack_h323_asn1.c | 38 +++++++++++++-------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> > 
> > diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
> > index 7b1497ed97d2..287402428975 100644
> > --- a/net/netfilter/nf_conntrack_h323_asn1.c
> > +++ b/net/netfilter/nf_conntrack_h323_asn1.c
> > @@ -276,7 +276,7 @@ static unsigned int get_uint(struct bitstr *bs, int b)
> >  static int decode_nul(struct bitstr *bs, const struct field_t *f,
> >                        char *base, int level)
> >  {
> > -	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
> > +	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
> >  
> >  	return H323_ERROR_NONE;
> >  }
> > @@ -284,7 +284,7 @@ static int decode_nul(struct bitstr *bs, const struct field_t *f,
> >  static int decode_bool(struct bitstr *bs, const struct field_t *f,
> >                         char *base, int level)
> >  {
> > -	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
> > +	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
> >  
> >  	INC_BIT(bs);
> >  	if (nf_h323_error_boundary(bs, 0, 0))
> > @@ -297,7 +297,7 @@ static int decode_oid(struct bitstr *bs, const struct field_t *f,
> >  {
> >  	int len;
> >  
> > -	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
> > +	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
> >  
> >  	BYTE_ALIGN(bs);
> >  	if (nf_h323_error_boundary(bs, 1, 0))
> > @@ -316,7 +316,7 @@ static int decode_int(struct bitstr *bs, const struct field_t *f,
> >  {
> >  	unsigned int len;
> >  
> > -	PRINT("%*.s%s", level * TAB_SIZE, " ", f->name);
> > +	PRINT("%*s%s", level * TAB_SIZE, " ", f->name);
> >  
> >  	switch (f->sz) {
> >  	case BYTE:		/* Range == 256 */
> > @@ -363,7 +363,7 @@ static int decode_int(struct bitstr *bs, const struct field_t *f,
> >  static int decode_enum(struct bitstr *bs, const struct field_t *f,
> >                         char *base, int level)
> >  {
> > -	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
> > +	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
> >  
> >  	if ((f->attr & EXT) && get_bit(bs)) {
> >  		INC_BITS(bs, 7);
> > @@ -381,7 +381,7 @@ static int decode_bitstr(struct bitstr *bs, const struct field_t *f,
> >  {
> >  	unsigned int len;
> >  
> > -	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
> > +	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
> >  
> >  	BYTE_ALIGN(bs);
> >  	switch (f->sz) {
> > @@ -417,7 +417,7 @@ static int decode_numstr(struct bitstr *bs, const struct field_t *f,
> >  {
> >  	unsigned int len;
> >  
> > -	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
> > +	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
> >  
> >  	/* 2 <= Range <= 255 */
> >  	if (nf_h323_error_boundary(bs, 0, f->sz))
> > @@ -437,7 +437,7 @@ static int decode_octstr(struct bitstr *bs, const struct field_t *f,
> >  {
> >  	unsigned int len;
> >  
> > -	PRINT("%*.s%s", level * TAB_SIZE, " ", f->name);
> > +	PRINT("%*s%s", level * TAB_SIZE, " ", f->name);
> >  
> >  	switch (f->sz) {
> >  	case FIXD:		/* Range == 1 */
> > @@ -490,7 +490,7 @@ static int decode_bmpstr(struct bitstr *bs, const struct field_t *f,
> >  {
> >  	unsigned int len;
> >  
> > -	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
> > +	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
> >  
> >  	switch (f->sz) {
> >  	case BYTE:		/* Range == 256 */
> > @@ -522,7 +522,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
> >  	const struct field_t *son;
> >  	unsigned char *beg = NULL;
> >  
> > -	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
> > +	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
> >  
> >  	/* Decode? */
> >  	base = (base && (f->attr & DECODE)) ? base + f->offset : NULL;
> > @@ -544,7 +544,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
> >  	/* Decode the root components */
> >  	for (i = opt = 0, son = f->fields; i < f->lb; i++, son++) {
> >  		if (son->attr & STOP) {
> > -			PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ",
> > +			PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ",
> >  			      son->name);
> >  			return H323_ERROR_STOP;
> >  		}
> > @@ -562,7 +562,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
> >  			if (nf_h323_error_boundary(bs, len, 0))
> >  				return H323_ERROR_BOUND;
> >  			if (!base || !(son->attr & DECODE)) {
> > -				PRINT("%*.s%s\n", (level + 1) * TAB_SIZE,
> > +				PRINT("%*s%s\n", (level + 1) * TAB_SIZE,
> >  				      " ", son->name);
> >  				bs->cur += len;
> >  				continue;
> > @@ -615,7 +615,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
> >  		}
> >  
> >  		if (son->attr & STOP) {
> > -			PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ",
> > +			PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ",
> >  			      son->name);
> >  			return H323_ERROR_STOP;
> >  		}
> > @@ -629,7 +629,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
> >  		if (nf_h323_error_boundary(bs, len, 0))
> >  			return H323_ERROR_BOUND;
> >  		if (!base || !(son->attr & DECODE)) {
> > -			PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ",
> > +			PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ",
> >  			      son->name);
> >  			bs->cur += len;
> >  			continue;
> > @@ -655,7 +655,7 @@ static int decode_seqof(struct bitstr *bs, const struct field_t *f,
> >  	const struct field_t *son;
> >  	unsigned char *beg = NULL;
> >  
> > -	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
> > +	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
> >  
> >  	/* Decode? */
> >  	base = (base && (f->attr & DECODE)) ? base + f->offset : NULL;
> > @@ -710,7 +710,7 @@ static int decode_seqof(struct bitstr *bs, const struct field_t *f,
> >  			if (nf_h323_error_boundary(bs, len, 0))
> >  				return H323_ERROR_BOUND;
> >  			if (!base || !(son->attr & DECODE)) {
> > -				PRINT("%*.s%s\n", (level + 1) * TAB_SIZE,
> > +				PRINT("%*s%s\n", (level + 1) * TAB_SIZE,
> >  				      " ", son->name);
> >  				bs->cur += len;
> >  				continue;
> > @@ -751,7 +751,7 @@ static int decode_choice(struct bitstr *bs, const struct field_t *f,
> >  	const struct field_t *son;
> >  	unsigned char *beg = NULL;
> >  
> > -	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
> > +	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
> >  
> >  	/* Decode? */
> >  	base = (base && (f->attr & DECODE)) ? base + f->offset : NULL;
> > @@ -792,7 +792,7 @@ static int decode_choice(struct bitstr *bs, const struct field_t *f,
> >  	/* Transfer to son level */
> >  	son = &f->fields[type];
> >  	if (son->attr & STOP) {
> > -		PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ", son->name);
> > +		PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ", son->name);
> >  		return H323_ERROR_STOP;
> >  	}
> >  
> > @@ -804,7 +804,7 @@ static int decode_choice(struct bitstr *bs, const struct field_t *f,
> >  		if (nf_h323_error_boundary(bs, len, 0))
> >  			return H323_ERROR_BOUND;
> >  		if (!base || !(son->attr & DECODE)) {
> > -			PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ",
> > +			PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ",
> >  			      son->name);
> >  			bs->cur += len;
> >  			return H323_ERROR_NONE;
> > -- 
> > 2.39.5
> >   


