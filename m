Return-Path: <netdev+bounces-228715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F2FBD2F3E
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F407B3A81ED
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABD226FD84;
	Mon, 13 Oct 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="NciEAcBE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D7263F36
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358180; cv=none; b=gBHyEuxL+vMaxqfSQGBBBOaS1COFzvoiBC2S14q8n7nr15cfk+PbundXhuwtuxJvI4C+G6WRAJkEIP67AfN8KSa+jJXfcgqlhXcsrbx+LcSxTVtX4xnxaS7RZV7Qy9wmINmfy+QvrLOrAeVo85ZeeJvBWehhhCGtd3XAsD1i3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358180; c=relaxed/simple;
	bh=Gn0eEfF7GOLkPlHIsKqjmnlwl8WmOTEyVrNvqmXwSd8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=icUoPO6l+tyDDP+4ifEyqDnsOBc7DAUUEivtdxq/QLjR0VyEMxuIpj9e1+iyJNqhgmesvAjR5rdxw7KVnrVHeiv40BVolziBR6EegQdTHXAoqrBZjWyZwGJO3mkMbHBogyWSe2JVvAh6uehA5PPSD8iW21zsGXgEQSnhLx04nQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=NciEAcBE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so3736450f8f.0
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1760358177; x=1760962977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=okdmUYlhFmHY6EW7sFMaABJgU4BMZvhN67KKvXy1How=;
        b=NciEAcBEGk3oi5VgC1+yMTiyX8CzVu2JKPfOZPu+BBQ3BfH/ChNpk9Jlv0mns2vAGl
         Bflpkuvp1L+O533S3Dn8Zoe1JXCq18cPmTUK8L+tTa/mHniuo0Q7ju4u8G89JRjFOxf3
         AK2fPFcGT96gQAcwXECfOHrgrBMaE5tJ7SUWnAREGkyvpDZ+DARcQ1ZK+PaGljp3UIlH
         8To8tNMDnwNIiJvJxygF6KFePv0fnP6erNrUfrOZv0mzVuPUuSxTeBcVpf7AgDT6n2ak
         WjqDsEiekd4zBpjr/PyOUuU0MaTNzhV9dN+VQdRKSN0QbWibLuZs2HlqvYGl/HqOPVgn
         rRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358177; x=1760962977;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okdmUYlhFmHY6EW7sFMaABJgU4BMZvhN67KKvXy1How=;
        b=fmYe/McsHCYwaiPssFxqPUWq8namxe+cp0J2EHAmg6OMnUm0UbEanojIyHkr4AvcBb
         dmi3xurEBRrWbazMKSwSH41skKQHVAxy03sfryKmDW0WIgHYUhtRiyfhBfWXG2zW6ER2
         FkVT1oQdflcRI5/mQjs+NHVYc1fM7mSOpDg0xE3SYuEuJLD8I/ZOJX4OtbBPAbfMCZ+i
         uiCQFa7zT105Oub/w6qJQo+vUddGwJtWCSh/hYMyDJljjj2rgoCi+5fH3X4wuPcoZzeI
         5H+ETF5PPSvYGbedkAVOkssUvouvI8jorNcAhasAgQWaLvLt51973ymRPirCa44B4eVY
         S7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXu8CkewgDuqD7bSr+DINk9l3utwACdSccaDuySZ3ZaxunoqtyQGcZ22Rd5+OEcQn7SvtnwAac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcivO/c21cwNrvAxxFl6LFU6kPuB8zfQ+QimSAVfsG6eT+GC5f
	vwwJloiYG7IsZa7mC9TLYlgitv8D3ZZB/VWUs+FJvXmC6y/6EzB06OqWtkJlPcdZjQA=
X-Gm-Gg: ASbGncsQIm/UlazZ18jnZA0Z80UhUeU+cBFv2dpXaNPl5izcVM63bDCgyUVzxVmHGhb
	ygvmeMq6hATLaC0LJh1yMgsgPtFLJ1ch9ruxXLM578HdiqjnS0DECqYpTTB5dt6hl6jZ4UTUGNx
	Z5ObnQ3+8JI3H9ugLHqpXF0QVqOzywSlgFvLkOtOMIscaGiU2Lhyx25R4bda2Q1xVN9V6nw63KE
	8Zd37v4T6mqXp314uyp8OtjUFWJvfkyR3UQO2k/LktizvpIHAo8ngj+mdJzxmHOMj64WxL5u/K0
	XnSXGnT3qiEr8Hi71tY4ZBkLjHTEzhzcQcORc++VMZwzD3M9xaFjO7PspbQRqJ3XmG6yH7u3F8G
	8XbHEn+eQ45nI5lRsJ5trz0GCxvaa2CdPkTds5+v1ZNXi1vn/ZA==
X-Google-Smtp-Source: AGHT+IHr+wgXBWFp5s45MhtPrwaRVRuqKDLgoBhkzcLLkcJ0zROOkiOZDmrmpFdhFhrJJpDhZnRrtw==
X-Received: by 2002:a05:6000:4285:b0:3e1:2d70:673e with SMTP id ffacd0b85a97d-4266e7e0012mr11904012f8f.37.1760358177089;
        Mon, 13 Oct 2025 05:22:57 -0700 (PDT)
Received: from ehlo.thunderbird.net ([149.62.207.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e81d2sm18220967f8f.49.2025.10.13.05.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 05:22:56 -0700 (PDT)
Date: Mon, 13 Oct 2025 14:22:54 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bridge@lists.linux.dev, netdev@vger.kernel.org
CC: alok.a.tiwari@oracle.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next=5D_net=3A_bridge=3A_correct_d?=
 =?US-ASCII?Q?ebug_message_function_name_in_br=5Ffill=5Fifinfo?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251013100121.755899-1-alok.a.tiwari@oracle.com>
References: <20251013100121.755899-1-alok.a.tiwari@oracle.com>
Message-ID: <14468513-2D16-4A19-9173-80559ED580F7@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 13, 2025 12:01:16 PM GMT+02:00, Alok Tiwari <alok=2Ea=2Etiwari@o=
racle=2Ecom> wrote:
>The debug message in br_fill_ifinfo() incorrectly refers to br_fill_info
>instead of the actual function name=2E Update it for clarity in debugging
>output=2E
>
>Signed-off-by: Alok Tiwari <alok=2Ea=2Etiwari@oracle=2Ecom>
>---
> net/bridge/br_netlink=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/bridge/br_netlink=2Ec b/net/bridge/br_netlink=2Ec
>index 4e2d53b27221=2E=2E0264730938f4 100644
>--- a/net/bridge/br_netlink=2Ec
>+++ b/net/bridge/br_netlink=2Ec
>@@ -467,7 +467,7 @@ static int br_fill_ifinfo(struct sk_buff *skb,
> 	else
> 		br =3D netdev_priv(dev);
>=20
>-	br_debug(br, "br_fill_info event %d port %s master %s\n",
>+	br_debug(br, "br_fill_ifinfo event %d port %s master %s\n",
> 		     event, dev->name, br->dev->name);
>=20
> 	nlh =3D nlmsg_put(skb, pid, seq, event, sizeof(*hdr), flags);


Acked-by: Nikolay Aleksandrov <razor@blackwall=2Eorg>

