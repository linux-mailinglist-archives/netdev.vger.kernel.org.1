Return-Path: <netdev+bounces-167521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6F8A3AA9A
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BCC3A606D
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BD21BCA05;
	Tue, 18 Feb 2025 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gi9EnsJA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8E158A13
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913314; cv=none; b=MlbnG3KgkNPz+F9jsZLqFlQkhZSOwCy6c6Y/s2N5UFjJiGpf14yIlTNrFyu4KjY3HhONlkukCLLeI/dBIoZL4SWpQt2lTEVn2ghSdvRcXfdd3OCAPmV5Ah52Nw/Uxs5LfYHMr+tmRE4hUZfR0PUAwxoeXmadASk5Rmj2KhBLig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913314; c=relaxed/simple;
	bh=cC9vUIpzrt6zvMqrZYUbA1ItB58D8zl71aqjWhUvDPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUcvbcofWTdt2Hl2GaPkcScpnqhLoasn9d3oM+SWU9zOe+RVvxggGs/yWGzGwx+GB17VGFuwjqv56xDzsts1JkXlf2DcxwVS70MsSD2HcL+ADePQNofXHoUnPJh3h4uQe488ZO75BJsxoRsITyB3sD77mIoimvuAx9UYGxkvBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gi9EnsJA; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-472049c72afso9460651cf.2
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739913312; x=1740518112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Us2UVu9HM9Mx+8iReZZJAVot8T6L4nmtvkAiGdFIRaM=;
        b=gi9EnsJAgtvhYaoLaPGAdvpFbSHOWRR/eSmaMiYGm0ZBUfCjp1zYI1mBS4U5pYbR/7
         bVdYp8UacI/yznMFrkNreOMddD829wGQBdBQh4yl8i/l/rp8MRK9Em+0yqsjQJCs4L1T
         Q8k8SSgMwFrgzfdbtiYC4zvfdJ8AngqOsZvvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739913312; x=1740518112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Us2UVu9HM9Mx+8iReZZJAVot8T6L4nmtvkAiGdFIRaM=;
        b=gXHLlM2uZU+L6E8rngSCuK5Bb67FV1WZ2Gvwa9KL7/1D61eHiEW+vLGm3K8e1+FV4b
         Ru0zfhXUjFthRYm1HmsluV3EcHM9tgFdDCHQaVlQeeKEQZe9ir5yBXiC4Y3hrMN8ziFx
         cShIswEdnkDsxCuVKdziC9FJwRqyZOmRZgfHA0pHX/iqIa8xN4paQgYed2Yy9//iacvY
         WVUAMP5wiYLDI4wODCraEQVFuOCJsvqnEupE3/3Yedvc3+gj64h8rQtL+f/iYdbMH5xl
         6Cnd1kukflZeZaVdb62llYQmQVmbLWFPMOXps7esepWxjdmR/cKXh+TAm7enkUvjWhpu
         kB2A==
X-Forwarded-Encrypted: i=1; AJvYcCWClfcFl5vZjMbNMzMjwIgCDu1f7nnroHgGahTqGAjZHvwzqEV7xdADp6G1W66L1yFD0MFMwCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYH0Sqxy99uQtM66Pb7Io3lwGqj1RBXJyf2r5c33i/Cm0aB6Ih
	c8wd26cnOXiEroWBHlURr5/vI6NSxEV+djKU5ZAamnZ2/+AOUJp9htbPmf5TxoA=
X-Gm-Gg: ASbGncuNdNaSHsUFtPJ459X4cKwng7Eo2DUaBc0JWl7oK9dWgCRtAT43P6Pe+gmmWrp
	BRXzkQjuwW2JBCANtVetxZqdwX1H+jO5uVUopPR8KMYgVqmua3fgRyAV8iF+342nW9i+ozxUKWN
	M9q3ViaxLDzqP74FwlCzZuGluEFpiT1zxYmfjaHO8S1B1d9I5S/xj/nH66QvNk5e7wHqco0rG5h
	2vdfuFPd6eMxwMLwVDXN3wAyi8LStsszz6dlJMOCtJ/lfamq+qscas/hOaLfoAerrTEjyqzXXhz
	7Ea+hsgAF9VPMHbY3EDd12NteHfy1tpAd1TlJvPE5a363IC2w5mNFQ==
X-Google-Smtp-Source: AGHT+IHOjtcR2kp1/8dJDlxIxwE1X8aBGduY/U9Z7QNBND7kEtKVNOGKmFyezcAeXr9jBbtkp5VC8w==
X-Received: by 2002:a05:622a:1190:b0:471:ffbc:9d6 with SMTP id d75a77b69052e-472082d78d8mr14975431cf.48.1739913311237;
        Tue, 18 Feb 2025 13:15:11 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47207919e27sm3988831cf.4.2025.02.18.13.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:15:10 -0800 (PST)
Date: Tue, 18 Feb 2025 16:15:08 -0500
From: Joe Damato <jdamato@fastly.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 3/4] igb: Add support for persistent NAPI
 config
Message-ID: <Z7T4XHtw9-EN-ifm@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250217-igb_irq-v2-0-4cb502049ac2@linutronix.de>
 <20250217-igb_irq-v2-3-4cb502049ac2@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-igb_irq-v2-3-4cb502049ac2@linutronix.de>

On Mon, Feb 17, 2025 at 12:31:23PM +0100, Kurt Kanzenbach wrote:
> Use netif_napi_add_config() to assign persistent per-NAPI config.
> 
> This is useful for preserving NAPI settings when changing queue counts or
> for user space programs using SO_INCOMING_NAPI_ID.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks for adding this.

Reviewed-by: Joe Damato <jdamato@fastly.com>

