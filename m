Return-Path: <netdev+bounces-210225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22E5B126EC
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811294E3595
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 22:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDDD231849;
	Fri, 25 Jul 2025 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC6Zfy9+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486A1A76DA
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753482913; cv=none; b=UAbOeFNrJeIBOSdlUlc6HAbw/Io2rUlF9xdZOLeJWb0OXLlbsDRoPRCPvCQ4zmurvZsJIpgq+7pBw8XsFVmcXmDaKqEA70Cx+W2GkbNkifZsbO1bJyKmmq2CvpGfcnXdfhVfFoFt7h32QjWCH5/wBA+lTkBdSmpMxY5qQvyN5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753482913; c=relaxed/simple;
	bh=DrsnVVsazD9OKin43SZoJUEjnsIeve01ac4IJBO0OqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AI6vMdzD2NzuRDCiYnpGqiwtk4HYOgOcOvLmO666YmJ18HyFYNnp2dMriBrCi2nbBn009wYcS95X08idNYqcq4P82GaG33fVPKZhNNzHfr1lXZFXVcC6b0n3JBOjGdgzn+STupOW4HzdHzHzFmQX9UidrgoUIgE1GxB8LaA6q4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC6Zfy9+; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso2111391a91.1
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753482911; x=1754087711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9d93v0QYLWsVDLSQsYRBoK/NHN7XjSnD6IDMcJ+8xvw=;
        b=WC6Zfy9+jMEfbGIki+9tSDbzQ506hJZ3KpLtR6I+aXRXuo4rpAIQlTIS4VsZ27ByQh
         KZXfM9U485FST5+Qh6Wq+d+aEMgvPYmYoimaJoiClceKmeP0k6L0R1YHsG2/OH6b0VYx
         ssJOVrcO6v51Kf8ptgJ76uDlAOwkpJN6nEp//bAddM3/7V0MktxGSeZP+7Jl2oA/DbXI
         EeYkMOHm/zr5AG+vLbWGGAyhNYBaWHssSLWH65A6CHH/LyJLnQul/YN/Fy80KPBp3HMb
         WwGjkG6BpjGGe+RQAj/nOlH8NSvZeHez+2fEH/TOoAwnFWSSCTeCNiYZZWHd02RBTbuc
         0yPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753482911; x=1754087711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9d93v0QYLWsVDLSQsYRBoK/NHN7XjSnD6IDMcJ+8xvw=;
        b=dutEGfpJm18dxFDSl42FdTQ9hSih5aVji2R5sN2td//McWc5+MCnUk1h3zD/xEQUNQ
         aj+goYJlvqDNp6SC3RzQdFuLk9HhP7I8f/GnBUog1NZ04TzxRgIOpy/lP3++0KjU+io/
         JiJ2Rui33lQ8BoMRKr7EuNqvAnhPQMGBIX4Pdw4c0NRojL9MQkhPC0SAiyzVXfNnKgVW
         1MdSM+wavn67PTDlYnbxOwdKsKSZzdpgYjfVbdki46uqvYSm6yy0lUzmDph/Vfmhwa+o
         JrMmX4YIkWxkNtibRF7iIg80C3xoQN3tziyTt3Nb00Z1AG0cmuSdgIkM5yu5eozO0Bx8
         /pxw==
X-Forwarded-Encrypted: i=1; AJvYcCWowVNtw0k1zw15ZlPciGkQM0EmdkvyFZL3SqKuAuymsbNIbZLJOPD8RWKwCY1OvMpGmO2dyds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9zDyI5xbR2psgcqWxh63rBSW0OLHij0EQXhSDKbNl1F20FPHS
	Ns0Dvz2R4/1PGRd5zQ2CibSJeRKKTVh+lEUVZYmBvhLwIByYu/9vwn4K
X-Gm-Gg: ASbGncthAGlNEnc7xLF5Kz1EfOBHeZ7LTqB3vU3PysUbMm3K4yRpsNYYC7CHspwV2QL
	BHXQVmY1Iz1jqDoGMqW2M95oFV1Gcj6Cn377kWPslIRl5YqqfzhVGyvayereexvfcA115AtOYhn
	FmFrsO30PHJpejU5jvaxWeGQqY2ITCUI3FY7V1qQXAe6xlybOZsG/hsuXU9eKznkBU8YYk67UGl
	YdClo0tf1dOisvJyxlBTLljz5Dbzfppsvd/A2dw6jaX208evt9O7Uyctk7KyamNKiqhBHGTv/97
	Jy8p3/mxuLL2uMctByJkzgQkHylppDx7d0tHKpcDt7Zu/MpvxVA9m3sMn9sBqIwjlW1nX60jPk+
	BpYo79rcSoZkZX3fqhyMucQ6x0eZ9Pq7z35rx
X-Google-Smtp-Source: AGHT+IGgRr+N+qhqH1Xa/kcZ80TjobDseoz7VE7sJ0yfZIKIkqpLWuMLF6i8Tryv7Q+JCsn3cbVK9Q==
X-Received: by 2002:a17:90b:4f4d:b0:31e:4111:fd8c with SMTP id 98e67ed59e1d1-31e778f4129mr5244230a91.16.1753482911174;
        Fri, 25 Jul 2025 15:35:11 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e6637a64esm4255828a91.32.2025.07.25.15.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 15:35:10 -0700 (PDT)
Date: Fri, 25 Jul 2025 15:35:09 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Maher Azzouzi <maherazz04@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: taprio: align entry index attr
 validation with mqprio
Message-ID: <aIQGnbRbTRihh6ii@pop-os.localdomain>
References: <20250725-taprio-idx-parse-v1-1-b582fffcde37@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725-taprio-idx-parse-v1-1-b582fffcde37@kernel.org>

On Fri, Jul 25, 2025 at 10:56:47AM +0100, Simon Horman wrote:
> Both taprio and mqprio have code to validate respective entry index
> attributes. The validation is indented to ensure that the attribute is
> present, and that it's value is in range, and that each value is only
> used once.
> 
> The purpose of this patch is to align the implementation of taprio with
> that of mqprio as there seems to be no good reason for them to differ.
> For one thing, this way, bugs will be present in both or neither.
> 
> As a follow-up some consideration could be given to a common function
> used by both sch.
> 
> No functional change intended.
> 
> Except of tdc run: the results of the taprio tests
> 
>   # ok 81 ba39 - Add taprio Qdisc to multi-queue device (8 queues)
>   # ok 82 9462 - Add taprio Qdisc with multiple sched-entry
>   # ok 83 8d92 - Add taprio Qdisc with txtime-delay
>   # ok 84 d092 - Delete taprio Qdisc with valid handle
>   # ok 85 8471 - Show taprio class
>   # ok 86 0a85 - Add taprio Qdisc to single-queue device
>   # ok 87 6f62 - Add taprio Qdisc with too short interval
>   # ok 88 831f - Add taprio Qdisc with too short cycle-time
>   # ok 89 3e1e - Add taprio Qdisc with an invalid cycle-time
>   # ok 90 39b4 - Reject grafting taprio as child qdisc of software taprio
>   # ok 91 e8a1 - Reject grafting taprio as child qdisc of offloaded taprio
>   # ok 92 a7bf - Graft cbs as child of software taprio
>   # ok 93 6a83 - Graft cbs as child of offloaded taprio
> 
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: Maher Azzouzi <maherazz04@gmail.com>
> Link: https://lore.kernel.org/netdev/20250723125521.GA2459@horms.kernel.org/
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>

Thanks.

