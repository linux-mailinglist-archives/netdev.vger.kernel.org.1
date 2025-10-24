Return-Path: <netdev+bounces-232359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68155C04975
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 08:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A77C1A65343
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 06:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CBC283FDF;
	Fri, 24 Oct 2025 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ja1ZBc6k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD3D27FD48
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289064; cv=none; b=TvwkXEU9jFRfZLj+6vZE+9LqLsVPeGavkieSbN4oDdwIXX5JNlhA1pxT5Rygl+mSH3f7i9Tyc3CCYAvEUPpbl0KwQ/R78UHl31Q51zWjsNLyH/TEwksBgWti8Q/+RLVEBlFbCyjwbsFNgnQBX5QsMBy051UmqxekKwO084+guF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289064; c=relaxed/simple;
	bh=pBsg4N5iwX+vr8FQPAvLLIFruNNlfZYeZ0rKXp+VOLw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KOV5wqqKWFfbevf5KITLjgGA+dNr2Js1FTjH2vwCOlIsY8r8/g/QjSNwKEU1y42ST5lEsmlBjJgA5083jc8NLw/bWGE6nQM4zREmYh215blp6X65ejGAV1alXumagKQPDZrT2XPSn9ELRaYgcwktrqEqu2i5dZFh+O5kaOnCcRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ja1ZBc6k; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42701b29a7eso879718f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 23:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761289061; x=1761893861; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBedczH9ospfENTMbnrZVqI0ZGrkWQpEsvwYb7t9OWI=;
        b=ja1ZBc6kR24YGa3k8rBRnex9Qxbr3z9+Evls7unqm7Tr/5mFHRWghD+GRVIQ9RABtN
         tJ8/KdVNXAnKkknm185JhjMLkjCKXnloZWc+xlyuqPD7wF7D9toQV4wBErJfgqw597Xy
         4vMrZSUzBXiPoGUd9NFpthdnVsUWnsZp1nN5uEBTm9VT7Cwu+wEbZ61xGNVHP35r/MYk
         PZ4ai1G/A2rFgg/9DTUAP4fQ9rYnZ3Q2JXfjKrCzQIVNQETpTDc3KsdbQ0jaWv+infeC
         2KN96nrCD5kfXepe9f7kuOTBRfK2QtRJAASIxsJqxK8ccpZCL+C+FSzvBx7M3pHI5NsX
         zCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761289061; x=1761893861;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBedczH9ospfENTMbnrZVqI0ZGrkWQpEsvwYb7t9OWI=;
        b=RTY9J4RnlOFq8BF48ki8CQblLdKpy8mjXIhRZRQAgLfsdnXlZmZNw6Ry5lvohrA7sL
         d1Q4lV/47+8D7V+SgOrFaFXGKJuoBukFdaT9ExiCG+1kd+nUWQWDFTIfQ8MgUN9Fjbh9
         48mR1o3X1YuPTv7lZT9w974fMJmpCqlSAoTn8cU2vBQOYgu4w457X/jbdcXMsOvQRNEy
         hXa12x3eF9ASAYx+fPDKNuM6dan+Ddaw8XQwEc/cOP9CnglrIXG50WPl+T95DKMHkJlX
         fNeqJcmCHEMCkrwXvSuQE4IYCgW2iP/vwVtq9X4OAMQiJV5EjYneJYWcIuAtcixpR/EZ
         7XWA==
X-Gm-Message-State: AOJu0Ywxws58gwct/USfQnxIqXX4Y88WJrmssKmcLMNCpyPv41hEA7Xq
	AvV7baiOT/YzLAdnu/ekKXdCZpaT272ZkuJ6hwsbCeW8QcV21F4lBBfXNZGUAh4YqtE=
X-Gm-Gg: ASbGncti0Dn4Ypx7rRct3gN1dqlHqRIRT2BkWZm4VafytvX9nmGb3kqmqlDeEwMxZmG
	oL50d9h+Gk8pI7w/kvFOFd+UVbiujAkgmiEg/3wpnoOEXoAVcHElu0DtXntzvM4FZEbKVPnyWlt
	McaAFsO9AMIn7HCM/QeZBDDY1sGaPI3dP5mhJKIS+ms2tkxZO9QQlY0eJ6oRlFC1TzRPQ5wUVux
	EXQqmSud/NrGDD/CKfGLQwqiO9zLttGnFNrArR5RgeK51uwfOyghw1yAETNljIVumSoJrq7iP8c
	eHCXvP4Vn46wlzM7zaguUDZyWxUF03RaTGgO8q2lErQr62y/BhmsE+LA9FOG2yd7Wjjitq7dmGr
	/Onuc2vGPLv9sDeiaLHuYkMRuCgGaancc4y5VZY8G/ZuGophDeoKrbsOy3wCvL3CSfO2FEPAZGK
	+bc6LqpA==
X-Google-Smtp-Source: AGHT+IG4AuuR7GiQsKTD1NUflrgESXZi2hlOAfoSSaEhm+UPRpMbC0JHlv8qPliADyJu4owUNg4u0w==
X-Received: by 2002:a05:6000:2512:b0:426:f4b4:f0fb with SMTP id ffacd0b85a97d-4298f51e726mr1172308f8f.2.1761289061209;
        Thu, 23 Oct 2025 23:57:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429898ccd70sm9471533f8f.35.2025.10.23.23.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 23:57:40 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:57:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org
Subject: [bug report] net: dsa: yt921x: Add support for Motorcomm YT921x
Message-ID: <aPsjYKQMzpY0nSXm@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello David Yang,

Commit 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm
YT921x") from Oct 17, 2025 (linux-next), leads to the following
Smatch static checker warning:

	drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
	warn: was expecting a 64 bit value instead of '(~0)'

drivers/net/dsa/yt921x.c
    671 static int yt921x_read_mib(struct yt921x_priv *priv, int port)
    672 {
    673         struct yt921x_port *pp = &priv->ports[port];
    674         struct device *dev = to_device(priv);
    675         struct yt921x_mib *mib = &pp->mib;
    676         int res = 0;
    677 
    678         /* Reading of yt921x_port::mib is not protected by a lock and it's vain
    679          * to keep its consistency, since we have to read registers one by one
    680          * and there is no way to make a snapshot of MIB stats.
    681          *
    682          * Writing (by this function only) is and should be protected by
    683          * reg_lock.
    684          */
    685 
    686         for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
    687                 const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
    688                 u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
    689                 u64 *valp = &((u64 *)mib)[i];
    690                 u64 val = *valp;
    691                 u32 val0;
    692                 u32 val1;
    693 
    694                 res = yt921x_reg_read(priv, reg, &val0);
    695                 if (res)
    696                         break;
    697 
    698                 if (desc->size <= 1) {
    699                         if (val < (u32)val)
    700                                 /* overflow */
    701                                 val += (u64)U32_MAX + 1;
--> 702                         val &= ~U32_MAX;

~U32_MAX is zero so this is just "val = 0;"  Perhaps the intent
was "val &= ~(u64)U32_MAX;"?

    703                         val |= val0;
    704                 } else {
    705                         res = yt921x_reg_read(priv, reg + 4, &val1);
    706                         if (res)
    707                                 break;
    708                         val = ((u64)val0 << 32) | val1;
    709                 }
    710 
    711                 WRITE_ONCE(*valp, val);
    712         }
    713 

regards,
dan carpenter

