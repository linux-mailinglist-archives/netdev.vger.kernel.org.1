Return-Path: <netdev+bounces-64840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4ED8373C9
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 21:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0471C21168
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 20:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F64210FB;
	Mon, 22 Jan 2024 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrLzox2x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362E82CA8
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955479; cv=none; b=YJL5k5ezc9ZzDmQSgOZJf1U0WnaLNXXPgUylihmQxQP79HOXM/SAuLEJXwiL6o6iDDDn4HXfMrzX+UBMxAk+/X3w7lyuuovHpR7U3fhO4jms4NFKdA+gOkJnosvBX0oktUdF0tKPfn9ezUkCvNc1BLviPkgDYH5nBzZ1WEz1tBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955479; c=relaxed/simple;
	bh=4PawHpWZBteYPGQoAKR1nj6H0GXT78vwoPghFictrPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7MclyqOyJLRCynIGTnTrhkSZszmAh+RJkOcSEacutIzYi9phT1FUcvff2kuUShnvgrGzuGWtqlyswZch+7u9tFixhfGJvwEpqoXkw4psyCVlYJkBQSbP2DqnY/1YMo9KVkspVbmkn2oCaUSpM3rAF5LyH8WLDd9dwSCfdaJxEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrLzox2x; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e800461baso43294065e9.3
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 12:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705955476; x=1706560276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PawHpWZBteYPGQoAKR1nj6H0GXT78vwoPghFictrPc=;
        b=nrLzox2xn40rI/LIcp2BNB9cZNqOnmH/nFEoAlcuGG12dwkulARPIWG2fhABxkng1q
         pJgvSWKonMB9wUzaDSNf7FVJQROrlSxHl57VFIfXz1dROwl/y5puslY39YjH3eX0WzNi
         5aiGBPtQ/XcJfdMJjsc1fTTsRT0bKI26JHzi/6BnAlRUMnUxdThuC3XtjZkz12ZbLtCT
         zHQZ/p+enfkWgNdQAtvgf41J6wkQJIwL0h0I0+WqhqY+hBs75s1apHt839oCpR98CwxF
         RfRS1QzqkQTPRirRHZh6KMZBUQRnFHYtcudYCzjjRtJpd7moksFPgDvH4phAkJg1tu5J
         20/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705955476; x=1706560276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PawHpWZBteYPGQoAKR1nj6H0GXT78vwoPghFictrPc=;
        b=qcH2lmBBtyaUSlbXqA3fIlLfdoUItN2DEERsdl7Se8AmNovfm34+jf8di2vhyjKxyF
         FCrkNki2ruI6JyBS8GQKQuj2zSKvPd2tdCEeQarzbBWyZKsE+fXCZyLA2zAzQZ5R83cP
         vDtpPUM/q/7Ox0Ac3CbXy3cJ4xhGUsDsP4CUKqSDRgBvWlxi19t7k28LSCQN9U2Tm56e
         Z4wx2Qc+Uuugk2+keq07vfGmLf6T3jcyYFgL3xMS5tmtJOmbtNNRWdf4hAP2AK1AzK4W
         rwqJF4toqq4vOmMwEo12e37IQ0fVMaV4kCzbTwFW3xk5vJLZ0lEGLJzXUyw/qV+wovZH
         jDSA==
X-Gm-Message-State: AOJu0YzzG5ilYFGUZaIAxhC7WhB7qzWJYlwc08916NMn+7l7EWFXxrca
	umu5SGyao0wbCv+gwgkPrTJJ4Ub+y3M7cTS/nsqAUzlPr8HtQYo/
X-Google-Smtp-Source: AGHT+IGLHN2zHb8cuiVahaqmB0V5MhppFDh06WTOY9us6NzwG0zZaVSoOyNkawXSXGJT6c+KwAJiyQ==
X-Received: by 2002:a05:600c:4285:b0:40c:dda4:3582 with SMTP id v5-20020a05600c428500b0040cdda43582mr1238578wmc.314.1705955476018;
        Mon, 22 Jan 2024 12:31:16 -0800 (PST)
Received: from ?IPV6:2001:b07:646f:4a4d:e17a:bd08:d035:d8c2? ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id g4-20020a05600c310400b0040e88d1422esm20084144wmo.31.2024.01.22.12.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 12:31:15 -0800 (PST)
Message-ID: <ca02156a-16e3-499b-a0b2-e4bdccaeca97@gmail.com>
Date: Mon, 22 Jan 2024 21:31:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] tools: ynl: add encoding support for
 'sub-message' to ynl
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, sdf@google.com,
 chuck.lever@oracle.com, lorenzo@kernel.org, jacob.e.keller@intel.com,
 jiri@resnulli.us, netdev@vger.kernel.org
References: <cover.1705950652.git.alessandromarcolini99@gmail.com>
 <0eedc19860e9b84f105c57d17219b3d0af3100d2.1705950652.git.alessandromarcolini99@gmail.com>
 <Za7GBaCiE+LUv6ZZ@gmail.com>
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
In-Reply-To: <Za7GBaCiE+LUv6ZZ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/22/24 20:46, Breno Leitao wrote:
> This is a bit hard to read.
>
> Is it possible to make it a bit easier to read?

Hi! Yes, an easier to read version could be:

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index f8c56944f7e7..d837e769c5bf 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -459,12 +459,13 @@ class YnlFamily(SpecFamily):
             nl_type |= Netlink.NLA_F_NESTED
             attr_payload = b''
             # Check if it's a list of values (i.e. it contains multi-attr elements)
-            for subname, subvalue in (
-                ((k, v) for item in value for k, v in item.items())
-                if isinstance(value, list)
-                else value.items()
-            ):
-                attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue, vals)
+            if isinstance(value, list):
+                for item in value:
+                    for subname, subvalue in item.items():
+                        attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue, vals)
+            else:
+                for subname, subvalue in value.items():
+                    attr_payload += self._add_attr(attr['nested-attributes'], subname, subvalue, vals)
         elif attr["type"] == 'flag':
             attr_payload = b''
         elif attr["type"] == 'string':



