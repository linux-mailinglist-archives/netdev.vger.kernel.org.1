Return-Path: <netdev+bounces-84268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F438962EE
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 05:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5961C22275
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 03:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3EE224DB;
	Wed,  3 Apr 2024 03:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0b/LIAQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0E1BC59
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712114849; cv=none; b=sd4P0dTryK/CtnNy2/l+xcy1n9Y+ye+Ma/CpYdglCuWavsMDFETaZRQEsEr1qzBu6HQcwMG5qjI+aObqUCga0KvIvgcSJerCN9hXPollV45JAHz0TeSkX2LiWsRelsI/aGy7UTFC3g9286OQMNZ4BNmHJ1+KrchAOg1Z2sjefUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712114849; c=relaxed/simple;
	bh=3DcUJUQf6Wa4OXd44pA2EifLwcLrk+26Cdl9DBdQFfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgWMBunVruSsCefcPX1kno4ZFFI7q2UhfPiC/wgkXJ1kHpu/5tiBtbphEGzhFONEZBQxlsoWzWM3v2EUW/S/c9PBUVVZ/UWL09zC1A4DsTQi0tTlUIIjBjzVEWxGtHCQ3HdABKF/64XpV36jLeodAIEvp5ojMUSTjuDkaKRglEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0b/LIAQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29f93c4946cso4303395a91.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 20:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712114848; x=1712719648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjrhfohyyhZYXmPTuNJHBaaFu2XauoKgKxYCWVGiSIE=;
        b=P0b/LIAQQr7DH5nhESOW074Sps9jsFTdzbj6K2dw5sVFNQS8YaptU0pzjdJK5Z5H1r
         zMh5b8SMxdVGu7/WluAvre6vcWBFFVYSI3Z9cW1xsxo6aDiYcC8JcUiWNtcKxd00ITE/
         BgoqjoD0pefOEcR+GxnCkPd3OmQgfP1XNFKYb3iQy7QlHuPfo7SU6fDyONjfzonf5x2H
         /PeMowF9z7l7DsKZ40ns5gHRNqa8OZZ8xzy+Q+1Zt/H3wGNDcrHaWjl4XBWYZDznJ41L
         BiVzHKReumnfBGZ/i+v5QlITcZUmk1EAjlaYqqSthZxcjct9NhW5xZAVT6poF28OhgbS
         rN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712114848; x=1712719648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjrhfohyyhZYXmPTuNJHBaaFu2XauoKgKxYCWVGiSIE=;
        b=xDoEhsyoYkXGLLXPc7Q5zQgtv67AhkVRSPO9nvT5kcXKuTMe//eiRKxoom0W3FHS7A
         L6vUEJjQg9+FrIYFYbkSA4DU3os/jk+s1UCWeUsUez2t7bXAwDz/wxCN964D0BaAmgUs
         CnnP71zKEmJycGT5qX/DMHYt8zkXdV/AVwIW90UAF+sRIbqgS/30wsZgUGF/sHI4loV0
         R5E/vRNwzS3xcZ8jpclPR70v/y3oSUc4M/A6Fwym5rDY5ixyrnwHqNb+aaTl0MsTnGus
         8g1JGoBeouMNAfe9tC4ZrxU3L/OFQugabMdME2czEvrD2Z6Q9tUKtv32jN8eQRLHcdEZ
         g+fw==
X-Gm-Message-State: AOJu0YzpLCR14g/6bKSwyrY1SCojCp6ZrfiI3lu4ztGVL3Pebq0woDfy
	DcA/AJxKzNIDcM8Dxnjz/mgLOkW2G6EhOP4M9HYV7O/DVzWn/2Mn
X-Google-Smtp-Source: AGHT+IEhqjBXtuRkOF7Iv8otGypAJNTjTqNBTnrxfTRnIumvgAyT7iWglb9a4MT8sSN+DPc5SsREig==
X-Received: by 2002:a17:90a:8b89:b0:2a2:18fb:683e with SMTP id z9-20020a17090a8b8900b002a218fb683emr10133063pjn.30.1712114847664;
        Tue, 02 Apr 2024 20:27:27 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gw12-20020a17090b0a4c00b002a06a806567sm10418875pjb.49.2024.04.02.20.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 20:27:27 -0700 (PDT)
Date: Wed, 3 Apr 2024 11:27:22 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv3 net-next 2/2] ynl: support binary/u32 sub-type for
 indexed-array
Message-ID: <ZgzMmqWzRvdk4wzP@Laptop-X1>
References: <20240401035651.1251874-1-liuhangbin@gmail.com>
 <20240401035651.1251874-3-liuhangbin@gmail.com>
 <20240401214331.149e0437@kernel.org>
 <Zgy-0vYLeaY-lMnR@Laptop-X1>
 <20240402193551.38a5aead@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402193551.38a5aead@kernel.org>

On Tue, Apr 02, 2024 at 07:35:51PM -0700, Jakub Kicinski wrote:
> On Wed, 3 Apr 2024 10:28:34 +0800 Hangbin Liu wrote:
> > I didn't check other subsystem. For bonding only, if we don't have the hint.
> > e.g.
> > 
> >   -
> >     name: arp-ip-target
> >     type: indexed-array
> >     sub-type: u32
> > 
> > The result will looks like:
> > 
> >     "arp-ip-target": [
> >       "c0a80101",
> >       "c0a80102"
> >     ],
> > 
> > Which looks good to me. Do you have other suggestion?
> 
> That doesn't look right, without the format hint if the type is u32 
> the members should be plain integers not hex strings.

OK, I can separate the binary and u32 dealing. How about like

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index e5ad415905c7..be42e4fc1037 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -640,6 +640,16 @@ class YnlFamily(SpecFamily):
             if attr_spec["sub-type"] == 'nest':
                 subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
                 decoded.append({ item.type: subattrs })
+            elif attr_spec["sub-type"] == 'binary':
+                subattrs = item.as_bin()
+                if attr_spec.display_hint:
+                    subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
+                decoded.append(subattrs)
+            elif attr_spec["sub-type"] in NlAttr.type_formats:
+                subattrs = item.as_scalar(attr_spec['sub-type'], attr_spec.byte_order)
+                if attr_spec.display_hint:
+                    subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
+                decoded.append(subattrs)
             else:
                 raise Exception(f'Unknown {attr_spec["sub-type"]} with name {attr_spec["name"]}')
         return decoded


With only sub-type: u32 it shows like

    "arp-ip-target": [
      3232235777,
      3232235778
    ],

Thanks
Hangbin

