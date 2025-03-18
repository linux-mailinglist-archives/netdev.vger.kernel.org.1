Return-Path: <netdev+bounces-175939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B39C9A6809E
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3707D3BC0B1
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09C3211A24;
	Tue, 18 Mar 2025 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SMGlz5a1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9901FA261
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339557; cv=none; b=AbNFzxnuHXCHHh8GpAYgCRngGbDfYbDcHjue4ymvzqB7irCZh/Y6o8T/J7Agbrd8B9WcNYColIdx2xs4AFxOG67T0E6BT5aKa+ojlY8zGwaluo6Axk/1mRKakbjAjyrCHsyQuMQrtzXWlXCQrubkYBPztLwN4aP/Mu5if9dTJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339557; c=relaxed/simple;
	bh=H/hdu/1P8rVoonX85Vie6+fv9UEYfCcpyCT6wFQutyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlWkpZr1TuRbqyTATTiktx0/8r7QhLUR0LZWFXBHt9/DenZdaSzDBqXYRctaG4edfJAi9jSFsDekKMauMDXG/LyMq+WthlL3E3ee7/A2X5EGFDeXXT164oTCOen7t6zqQU0hFDVT3hxkOKDJgpd9kvxGd/GqZ0sbGc4F+fbTeb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SMGlz5a1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-223fb0f619dso105326895ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 16:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742339555; x=1742944355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaRndpvh2uGKNsKpF3eM2XPoI0oRbaMDgD+9J79xLtw=;
        b=SMGlz5a1nQ0ABgAUxxvRmsvdg9Efwo3Y3PXT+0nz4ATMuPGj+AE5DOfmEjeBVcr1H2
         uiHyqzI9QsKy+Q1trqpjTDnaTYuw0DzAIfLQUrxMasXxPrp4nPoe2w93WBFjTDy/s+Sy
         LC1PCQ4nzuC0a1BKiXZYcsPJTTsAzCrrR4Srs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339555; x=1742944355;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaRndpvh2uGKNsKpF3eM2XPoI0oRbaMDgD+9J79xLtw=;
        b=pLZRWcJjWbz4oMV90E/G/TaHQCincigoEidPoaVb9cDlvvtUFUA5W/P3Q6IkA3zIeq
         6n0qEKuWBqOS4PLX+6ThqiXQmcSeCwKg2/39WcE1xexNjzsr4OmNRn0y9pU1HayvLZJ3
         MHuoN/72VrE4bET/YGRmor9lPWbqnzXxPEeiVOJjCmFN2kdewYHr8fDedRou8GVNTUF4
         411mu91ddvpBoHtNBw/iRnDRhkfMfaFljxYwWR95HpGjFlzQbrdtjVk5Ts22zm2dkfUI
         bSYYFHX0xVCJuRog9GFPODANWFqopMXQJ+5Onr/Swn9QbWX88K37fDEfdWCZva9BKS3a
         j3mA==
X-Forwarded-Encrypted: i=1; AJvYcCUNQWqHx2spfRMHwg35sfKbMCefYaFDSya3RnN4ocPs+WPoFStAL+AIx54m44qvI2aLFryezVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtl24TzM+T7hH/fWwO/ZDi1az9WknFpSUIgGgA2reVvFtpLMO
	DFVDpS/Eoc/dTdmoEdnKwtufXHnj/VchchZ2X95cKzGkQrfDTmAanlQdk/BnbCk=
X-Gm-Gg: ASbGnctlK0yNiR+Tm9rRQ3VzW8DncYClYIpMaWmgwjsUVP8NrbQuU8xJTOnyKAYRYQf
	znOKkm7OpPac/HX5VRVLsmSKQFLFIGjrpf4T09PWeNUJjYLm+QJVJ3QO6y3xdqQo36m/MXiKNVW
	WRgk+XOi3yGM5coOViJx/q1uNB0AQJie+dHTMbUERGGctAtTn8nUAPfSrNpZJNGCiTZYDwDcjUw
	FqLaCLEPjKdNpSb8pE06gixiEbHFsQCQEh1AShsZ7mP3A7R66rZE6rsFDlxorskr5V1LjnDlooC
	rekI85X+ougEDT/dSX0V7lClsqevC/GfMGnLeMjENH32pKc3gGCpj1a5C41WZ/2+61OlCStBx0A
	P2eYPlPlVRaCEuCtR
X-Google-Smtp-Source: AGHT+IGCqhuoXqistpYaO95esytvSsTMf96f353fE19L3PbMNXVwiVOetoAgKaMiPYbe7DqKqI7dXg==
X-Received: by 2002:a05:6a20:e196:b0:1f5:64fd:68eb with SMTP id adf61e73a8af0-1fbeb3911abmr962857637.7.1742339555385;
        Tue, 18 Mar 2025 16:12:35 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea7d9ebsm9652684a12.58.2025.03.18.16.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:12:35 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:12:32 -0700
From: Joe Damato <jdamato@fastly.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 2/4] af_unix: Move internal definitions to
 net/unix/.
Message-ID: <Z9n94NKtHlDtFF0N@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20250318034934.86708-1-kuniyu@amazon.com>
 <20250318034934.86708-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318034934.86708-3-kuniyu@amazon.com>

On Mon, Mar 17, 2025 at 08:48:49PM -0700, Kuniyuki Iwashima wrote:
> net/af_unix.h is included by core and some LSMs, but most definitions
> need not be.
> 
> Let's move struct unix_{vertex,edge} to net/unix/garbage.c and other
> definitions to net/unix/af_unix.h.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/net/af_unix.h      | 76 +-------------------------------------
>  net/unix/af_unix.c         |  2 +
>  net/unix/af_unix.h         | 75 +++++++++++++++++++++++++++++++++++++
>  net/unix/diag.c            |  2 +
>  net/unix/garbage.c         | 18 +++++++++
>  net/unix/sysctl_net_unix.c |  2 +
>  net/unix/unix_bpf.c        |  2 +
>  7 files changed, 102 insertions(+), 75 deletions(-)
>  create mode 100644 net/unix/af_unix.h

Nice clean up.

Reviewed-by: Joe Damato <jdamato@fastly.com>

