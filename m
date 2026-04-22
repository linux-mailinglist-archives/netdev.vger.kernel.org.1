Return-Path: <netdev+bounces-280498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO8pMtj46GnLSQIAu9opvQ
	(envelope-from <netdev+bounces-280498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:35:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA24448BC1
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7678C30DD2FA
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8A53876D2;
	Wed, 22 Apr 2026 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nhgmr/dD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7I6QI+S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6203845CD
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875116; cv=none; b=HGX5NRp3Zy8M+NohVkWESnOjwsLzwshMSFTpT285/Qevs0hmFUo+XxIJ++aeBzdkzPBZoOiwt4M/0Pd8pyZzS/LW4CEHH9JC2LU50XXbipaXa2dG1UeyatwG71BhsbaZdiBHvUgc3wCFOtbdXjSdjM6gNFjsEP5JL3q+8AJfjHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875116; c=relaxed/simple;
	bh=aGdnrrjI8lPxcmoVxdZhR1KhhfM/YGirogLtJVSTsZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpYTguOQj0W/Mj153WWbs5sFM+0tMwADyCal8fgZejXEbdWaUJCPdw4c7FXv6KGXJ66D7ljqtAAvxqj6pXyqc4r0z+AGy34EktBk9+snoukWrQYGvNP7RyL2JJ/3sLeBAaYhMxgrRCGR07VmM113JfPDtzmoxB0p9jw9Swl6sUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nhgmr/dD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7I6QI+S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776875114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qSFlJjwss7taNy6z+vQcHuBtEn5xpw5EWTakbtj//YQ=;
	b=Nhgmr/dDhD/WF3cUr1wKhpZvsVzrfQXmbYTJR07YhB/MziLota+KteNxvYD7jRwVNspSuz
	uoWMsgYqFmUR0OwfvqJhRfZtNHibZ1k6aD0epgAoMPXTIo81ve31440rfkTuFEqe50Jk/f
	9SXJruiiI/ehnsOwdan9ChKyGKKxYc4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-w9QHXuYEOtWo30lqNm0fQg-1; Wed, 22 Apr 2026 12:25:12 -0400
X-MC-Unique: w9QHXuYEOtWo30lqNm0fQg-1
X-Mimecast-MFC-AGG-ID: w9QHXuYEOtWo30lqNm0fQg_1776875108
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8aca3b7b536so147995056d6.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776875108; x=1777479908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSFlJjwss7taNy6z+vQcHuBtEn5xpw5EWTakbtj//YQ=;
        b=F7I6QI+Sb/2eaVY3wVC9PNDa7kGujNF+tjVKEfg6swoSjTDmi+XBrqwQ9cg3D8KQ0Y
         5Zubq4lhGKq8Qrfe6dsZjVvPLiN/awL7dzPP/rWkR6EWyBtqNaG6D/SE4MFNwpjqPODx
         82exuraZcErzhnnJ7P41LQRt4eaVQBVeAM3bXSBoSUqsTk7M7lHspLDhidGGyUncAefO
         JBVteXOhDVZhKtRfQtTCt3oATwAC4XO8KAtj90HOhdc/BfySFEain+t8Z036T4ZjstlS
         lugf88Qw4dei4S5l4Im/CL50Kzew++urEvwz0gFN9RF5QJ3h/ppDIatpxk4S6D3cqLS1
         dggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875108; x=1777479908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSFlJjwss7taNy6z+vQcHuBtEn5xpw5EWTakbtj//YQ=;
        b=pCi37LTNjcegdBcBnTu/sOPaAZjZoAT8wRPGScVwErUZT5Jb8vX1/wUK8ODYXbU6FU
         +jenW+mqKwlhn+wlEcR2mmSQww5v38vf6cBQlUWsXryoo0dhM8mqZrUKrOea2bda+zhT
         JO5EVy1rBxpNGfW9TYkYsAE9mQAwV40dcIrJjbg7FQsHwHd56EIF37qXlgwri5CM++jJ
         eH21bqzNTIoxKa7f0cNMs7u4bX631cxJUrtjjsCOk1rUNL7w2Tp2n16iVJrlczpEgVbn
         6rtytYGxATQP6l6DsfN3X8v+6fN+WbJ5ur6ELHACV3OTxnKMD7vDVvMwLwWIvVySY88v
         gd4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9T5EAjOfO/IAHWFylRc8T5kSUxg1EH7PQbjO0GsovPivTGDZ2bozPeNM1pb5qR9SIFo1S+Uss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzis9Xx3XsMqUx1/fjjioJXdOkYC+j9Q3RqvCV3dLM/u5sykt0/
	D6P7Ia6ON1EI03vi8jQ3KZkoexVoC9YCwmnZddXtAkJ9XInyvBfx5iLxTVKsiqo+gIq0btQelPA
	2xnhht4IogO316ebzt8hoY3pzue6sb6M60Gf2MCnwYbDxGBcYvkmZBVjurg==
X-Gm-Gg: AeBDietyvN2o9qf+eBvpYVe7FOj4nDySFG5hGBACvG0XRtAZDj2I92jwYs1Zs9Ga9Sd
	wB/ZXuBaqFngZL2mrB7vfr5LE2Mzg+1MvOFFIHof6/PPTkW5sIQZ9/gZ722GGXXkMNx3iU4zqL8
	kKvkwcF44D8dJqZjnMlgMApV2e8b4ajX4zlHDphh0+ZIDvo5YvS7FJbunBZQrqlvGyocm63xjtu
	M5vUV31hTuov81tWwc+iWK+NFTXXFiPk06166qMiJ/6fK5X4hi2w45O8y0kjVCBPk61Hdb2geV7
	YCdbQng5KzY/geDbsCSMMYnN7QOlrHoNg24RHXQao+wxm/uQO5TYvnZgeZqzGtGnuTS0Nbod9sI
	ZkkjZt9gTLCiLI1iUUp2Fu+8FZ1R7NmGh2h6NTWqijA==
X-Received: by 2002:a0c:e007:0:b0:8ac:a893:8b5d with SMTP id 6a1803df08f44-8b027fd1849mr309816086d6.7.1776875108452;
        Wed, 22 Apr 2026 09:25:08 -0700 (PDT)
X-Received: by 2002:a0c:e007:0:b0:8ac:a893:8b5d with SMTP id 6a1803df08f44-8b027fd1849mr309815476d6.7.1776875107978;
        Wed, 22 Apr 2026 09:25:07 -0700 (PDT)
Received: from rh-jkangas-kernel ([2601:1c2:4400:6bf0:7677:bcee:4ef0:e09d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae7d79esm130910876d6.36.2026.04.22.09.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:25:07 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:25:03 -0700
From: Jared Kangas <jkangas@redhat.com>
To: Dan Carpenter <error27@gmail.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/3] dts: s32g: Add GPR syscon region
Message-ID: <aej2X2Gp-UI3Vmvo@rh-jkangas-kernel>
References: <cover.1769764941.git.dan.carpenter@linaro.org>
 <0e922537c02d1c47734142090f98eb78e921ed34.1769764941.git.dan.carpenter@linaro.org>
 <aeKn2dvOOO43zdev@jkangas-thinkpadp1gen3.rmtuswa.csb>
 <aeZOcCOgMy2g9wqp@rh-jkangas-kernel>
 <aeZYQp9b5aoV7Ihv@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeZYQp9b5aoV7Ihv@stanley.mountain>
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280498-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	FREEMAIL_TO(0.00)[gmail.com];
	GREYLIST(0.00)[pass,meta];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,kernel.org,lists.infradead.org,lists.linux.dev,vger.kernel.org,linaro.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.341];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkangas@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email,4007c000:email,64.7.192.0:email]
X-Rspamd-Queue-Id: 1FA24448BC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 07:45:54PM +0300, Dan Carpenter wrote:
> On Mon, Apr 20, 2026 at 09:04:00AM -0700, Jared Kangas wrote:
> > Fixing Dan's address based on mailmap update, sorry for the noise.
> > 
> > On Fri, Apr 17, 2026 at 02:36:25PM -0700, Jared Kangas wrote:
> > > Hi Dan,
> > > 
> > > [snip]
> > > 
> > > I gave this a test on an S32G-VNP-RDB3 and didn't see any issues on the
> > > dwmac-s32 side, but this appears to trigger a panic when reading the new
> > > debugfs regmap/*/registers file for the syscon node:
> > > 
> > > [snip]
> 
> Oh, ugh...  I didn't realize that this wasn't merged.  I don't have a
> way to test this any more.  The simplest fix would be to do change the
> 0x3000 to 0x100.  The GPR63 register is at 0xFC.
> 
> 		reg = <0x4007c000 0x100>;
> 
> That's probably the best fix as well.  The later register areas would
> be their own syscons.

Tried that out and it looks good to me. With the write routed through
syscon:

    # xxd -g4 /proc/device-tree/soc@0/syscon@4007c000/reg
    00000000: 4007c000 00000100                    @.......
    # cat /sys/kernel/debug/regmap/dummy-syscon@0x000000004007c000/registers
    00: 00000000
    04: 00000002
    08: 000000e7
    0c: 00000001
    10: ffffffff
    14: 1fffffff
    18: 00007fff
    1c: 00000000
    20: 00000000
    ...
    f4: 00000000
    f8: 00000000
    fc: 00000000

No more crashes and 04's value lines up with the S32_PHY_INTF_SEL_RGMII
(0x2) write, so if you're able to post a revision, feel free to add my
T-b:

Tested-by: Jared Kangas <jkangas@redhat.com>


