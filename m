Return-Path: <netdev+bounces-231276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E54BF6D9D
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58389503E61
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690E82F39C1;
	Tue, 21 Oct 2025 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qco9XJSn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9C2E9ED7
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054145; cv=none; b=pb1/PyQg7EKk0rrXXeYOgiyG6+8xCcoOO0j4hJ1bs754LG6kvzGYw03+2/QfmtPs481v1r/BPdLS0INNi6f9OKyjjJz10oRmfCggbJQXTmKbJwnwHLvODOKdkn+B1Tt+xVIM7KHBLhGDr+Txi7P90n2Uv0V7TAvZxuHdCO/5obU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054145; c=relaxed/simple;
	bh=bxHGLz+xlJewzMmRFIuIR23gQThD28fVSG7QUjGyY9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsZwkDdO2f1jvrvDOhlLUkfq8HPX73ScDwSuJuJqw+51NlPxrd6JiRcyNz5FvBbcPafLNfwKODnd0UopcJbJRMzWN/TtKnuz86KGKsJTMnVz/1yaHajD0qmGY9yZVr40h0aoBHZ1P2jySaEfjTiJ5gu1vF1fU/d05mWeJrjJxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qco9XJSn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so2320165b3a.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761054143; x=1761658943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgZPMxLu6X9wz+t1vCeUGO6rtKpKjgYYhFE+lvxINzo=;
        b=Qco9XJSn8o7aI7jdnej999Q66H4OF/VjuIKBTfCudYuafg1UVi1nseppeUfwH4ea1d
         Z2PPyBMozXJYzWqvNU4l0rULNb3p/5uCHR8Gp3vMbB3bcbFIwEzh3i1uen4r5Yp6lNC1
         n6F2gLb5kBy2K69Td+Y/5YJhsMX3JXhlTmmwMP3q3jd0Qz3MqMwLc9O+G5zm9P2FHRpZ
         +BuQSYEQeGs4VZb32Xu7d5yDMlSpQ8CQ+iTaQ2d3xkjToyqRtCJrELpHl0CFNImyY+Lg
         o49fjDhsO9Deed8OOfsouuVjvq2JnrijkquNucDx5HGx1gSUGPQ+c1KiRCGkR+c5F81x
         RcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054143; x=1761658943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgZPMxLu6X9wz+t1vCeUGO6rtKpKjgYYhFE+lvxINzo=;
        b=K7gwO71QH7YamaF7HeKTcyl+mH6L2AiucIa3KVts/asabU9owRQA7d1PAma1yn+LH3
         FfcNzJCMpP4JKHe2EzHEfmbgKvrAeO/c9ze2wuPo+6JkFgfs53O9fw0qUM7LAceNopCA
         KxyJdWl8r9bVbml8IdaOYObjyZr8NJS3Xee6Ml7mNLJ+rLSoMYn9DYbxn+Q1l8wxdWef
         wEh56re2lO7maKEjGswKdSa46BCRdFMhyAjZpQxpT2196W/Jfa/wKC6goFmXQz5/jliK
         jY4RwVpqqJIbZ6TxFHSpdNKnMha/NjFDpg1+m//MZNRq5PkEr9BJpRw9Jr5Fz04cYctj
         uedg==
X-Forwarded-Encrypted: i=1; AJvYcCWvJzR66oRlauLRu70mHeiMQwEt0DqGRoe9bV0risPTt0EWxGqmF1zNv/NgPiG784xrc1C+ILA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylp3Nga0RnW0JE0Wg+nE2SeKsC9c3DIfMttRrgH1nPU1kUio5L
	adYJSv3JKPmpiP3CS03N2HXbiFkpsTiLFG3xvGl3f57cuUzUWCqby7YT
X-Gm-Gg: ASbGncvKY1QWa3hUaUfFEl0EyA6plYVK5qY3258LnhuCZKmVJ7sjZ+JMXL0OanYj6pI
	x5w320JlOvERmr56A8jUDaNPzTsir8VlOJqU5W+4XVhtIaZPbGV4BTt/DH0IWi/3+QXQx/nbEOq
	uWqGYttO/K0PXRLdlR/oHkSJ1QnPVUQO8w+QLq3km++aDq4lyKFzfCDPaG72D9KlS1OFRsUl7R8
	BFmqjzXRZbPCuYUvnPzYW1yjtiuquT6OZoq0Lc8D+9lGcpG5SVOQmJ58tWVEo5AOzbeaSOWWHeQ
	x8j9JFUi7zfMU2SCOnY7O1PGcYn0nYaLb38eu9TLqdPfqRgBWT7yTREz2BY/LFZB39D8pm++3hy
	XQEECyPK7VypXbGqIyAK7vS/Zrqq2Y65rZkV1kUl0L0kJXZGaJmO3+sY8i7b07N5I4jnmTx0Poc
	0283JcZp0nsrHsfsxfPM2FMTJeEjzR
X-Google-Smtp-Source: AGHT+IEtBrPuQQUxw2bft59BW11T/7eOEgF3RMVKZ3jPGBy5mT6+NnW6S4WaVnFWlQfeAnAVDZwRzA==
X-Received: by 2002:a05:6a21:6daa:b0:32d:b924:ed87 with SMTP id adf61e73a8af0-334a854ac50mr21383426637.20.1761054142909;
        Tue, 21 Oct 2025 06:42:22 -0700 (PDT)
Received: from t14s.localdomain ([2804:29b8:508a:1537:573a:39d:6287:7ddf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e211sm11306341b3a.62.2025.10.21.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:42:22 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 60D4711CF92D; Tue, 21 Oct 2025 10:42:19 -0300 (-03)
Date: Tue, 21 Oct 2025 10:42:19 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 net] sctp: avoid NULL dereference when chunk data
 buffer is missing
Message-ID: <aPeNu7-COwBQS21U@t14s.localdomain>
References: <20251021130034.6333-1-bigalex934@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021130034.6333-1-bigalex934@gmail.com>

On Tue, Oct 21, 2025 at 04:00:36PM +0300, Alexey Simakov wrote:
> chunk->skb pointer is dereferenced in the if-block where it's supposed
> to be NULL only.
> 
> chunk->skb can only be NULL if chunk->head_skb is not. Check for frag_list
> instead and do it just before replacing chunk->skb. We're sure that
> otherwise chunk->skb is non-NULL because of outer if() condition.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 90017accff61 ("sctp: Add GSO support")
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

Thx.

