Return-Path: <netdev+bounces-225370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0236B92ED7
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E9344782B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B322820D1;
	Mon, 22 Sep 2025 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0K6bGSz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DCB2F0C5F
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569925; cv=none; b=GuwP8vEJXbTmuwj6gEkO3fbZOERBTZgORbj087q28+SaoQnsQRWxtfLoEk629lXTh9MgkK5dA9KfesPu2p4H3PGiJCy2u433SMP2+bKZ1MbsIVXHDSsBzB1Ddbg3aBtNCqQqMY3t+sqK4zDO4nlELIO2+Vuv9E7mMyTnIau7tcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569925; c=relaxed/simple;
	bh=zSkwFxdawuhzp1rpRWhOyjFp/r0ht9I8B+KlJS0Nahs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iEfmvw+bL9IVU9l9TgI5aQLLEmoUERTqQlQRAieeIAagGis+gmGhrxSmfDSa2Bm8G6T4r7KldOiPRdE9556NooJTSJcKwc6+551hcjz9Vw6G4W7qA/8HAWw840EwEUN8V6Xu2iVTDqBIpxoPLM11nu506nhxfLti5sWcRq48U0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0K6bGSz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4d16cd01907so7436541cf.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758569923; x=1759174723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxb0la0Xz6K3HZRfHiufAhiCg3Bf0VK65WFpq6/jGV4=;
        b=l0K6bGSzTc3nbH1O0AL6rwTQSsUMT/Dvo5kV7IEhsqsOoQudmxEE3mHII2VUFvclp3
         B/Z3I4QpqjqWiMLT6fzchI1PyHAH/fPh+gRlYLMzCA7p7qpE5P/pzgP8Yc6Qt8QKgf5K
         3rOkyOvdEgcDizj0vu6JsJcRxzUaMxJ5wuouuBgY5salm2R30EDL7Aalb7rr8BaCdwCv
         94wztORklPAqnfi+3IbCQ9f9Bb+LxD1OjRFrX5/Mxaf/Rw+T3QDlKWgOMOzIwWJ/c6Bp
         i9y8CuE59/lVW78uKG2ojxlqX9o2iN+TwCsczY16ovIUxH9Ip9n1D33OzMtRWe9JoxAz
         ClAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758569923; x=1759174723;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fxb0la0Xz6K3HZRfHiufAhiCg3Bf0VK65WFpq6/jGV4=;
        b=HsIDGlJwVHJA3BVDr3x4snq6+TeV8+eVLfRFmCP3CcSG8/q5c6Y7D3xHlhJu1grsNW
         LHi1BOvJ8X1fdabtPc8b3xeGQcvFu1ZNPxn3pfZemzquWXMTJNYJj7fG3WtJ+XcgtfPM
         w/u39aUHvawskRfX+jbeeh0Hqi6gPToiTPhL6dn8OXjWIJIJAhVdPONtvQsprKC0kbCL
         pcWMtfItvWe/n17KuGe2ZB47kMxCu/0a4hWViPDKYQokIRIF35jDEbzjdEy9it+dT9Q+
         0eMBS+sScc2x79Exg3+S266ioIgGPKM7zkQd7TEO+FAA0f7oLfBfZP75g15INj0lPwoY
         0BIg==
X-Forwarded-Encrypted: i=1; AJvYcCU1a6aCA3g3E9rd/6FFlSyVFcyxYnMS/vNMiTnY3U0d4CrAOuWVd21+HH9TxCqTtpNW/foxv2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRNmJ5aRmnmTt0f4b1Btf5Lnv/lVeyWQhmt/eheNUAPaPel4or
	NmBmwkY7IxIrm4Qkj7rzzucVLGPjFsJbpOVW9PhNHDCpcyikfgCGkYC4
X-Gm-Gg: ASbGncu1Zd8BwhJcem8x6k83lRizmW5S6L3jGbLl2TJzS19OSegYAQKE14Dm690QKWl
	hX7V2rEB2EwwD84/ZVSgqg7rQQrwCMfFF79gx8SRc/xi4FLzBMfDvtZTwDhU3dy3LMCLu/oLkEx
	0/sGuoLSyyGZla9O607rXpCasNBr6cvXo7kjLCLg/89DShvBnGKnt0dkaSCzIapCtLy1UZvrvEg
	vimyxrjmvuwXmq0nVGBLw9MH9Gr0eALW9qx2t4fmshgLDabbrx9Hhx4MliwGcVeSu1NbEZx3gPz
	awi/2tS/rWJp1KAPxXAnjsJfyb+F/gYh+DFJu31Chfgn2VjybYor/P0IjPTBtG5JH9XMnO2fMgp
	FDIDoJJsozE12F7fGdW29EgXJZC/6zoDB6tHB+2uFWEJikzrAu8rqJGga/mNVkWsIIB5N9w==
X-Google-Smtp-Source: AGHT+IHERlRcxB2cgVPJSZcI9+IMM5lYOVHfSDwqHjbWSaC8Fz6GFhkMqV35fhCj4HyUwgpMTDhivw==
X-Received: by 2002:a05:622a:1650:b0:4b3:10f0:15b8 with SMTP id d75a77b69052e-4c076040eaamr170655631cf.77.1758569922833;
        Mon, 22 Sep 2025 12:38:42 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4bda15f91a0sm75500011cf.1.2025.09.22.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 12:38:42 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:38:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 ecree.xilinx@gmail.com, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 Richard Gobert <richardbgobert@gmail.com>
Message-ID: <willemdebruijn.kernel.416ce098eb01@gmail.com>
In-Reply-To: <20250922084103.4764-3-richardbgobert@gmail.com>
References: <20250922084103.4764-1-richardbgobert@gmail.com>
 <20250922084103.4764-3-richardbgobert@gmail.com>
Subject: Re: [PATCH net-next v7 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Only merge encapsulated packets if their outer IDs are either
> incrementing or fixed, just like for inner IDs and IDs of non-encapsulated
> packets.
> 
> Add another ip_fixedid bit for a total of two bits: one for outer IDs (and
> for unencapsulated packets) and one for inner IDs.
> 
> This commit preserves the current behavior of GSO where only the IDs of the
> inner-most headers are restored correctly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

