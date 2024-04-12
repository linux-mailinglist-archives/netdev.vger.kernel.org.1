Return-Path: <netdev+bounces-87440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC89D8A320E
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A681C2106B
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11941482E3;
	Fri, 12 Apr 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QUXuvZ8k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E628143899
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934853; cv=none; b=JADHlJS8O8xwh0zJmzyWW9ZxyNFkY1QkiZl84pjfn32BPxB/Ljl8ePDvOKg/Tbb41wt/KUk/lGoy+HIIJJnUdYxRo+XWyaBJ5hQWQImuupbKqKL9Kvw0AwaV7haMJCjU4M395PcNk5sn0ZCEi52Pd1i55KZQ1u/bLwHrJoTATGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934853; c=relaxed/simple;
	bh=fvTrRH4DLn5mnkphu1F/WSdXeIOZNYO5jK6aFD3PDrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJ+h3oKD3coLWffzG54C7K2Crb8KMol0bCF8itd55Htax//oh30ZV9LnLJhM3jwf3pMZkWmU9ned4Jom2xRM81O5FtxYx1RrqivIaGgAsQB02kJefoAKFJQAv/1ESi0jkPaaY6pC+spjj3ILgfZOzJ5GnZAdL9dUXX3YNQVJOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QUXuvZ8k; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d82713f473so16082551fa.3
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934850; x=1713539650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fvTrRH4DLn5mnkphu1F/WSdXeIOZNYO5jK6aFD3PDrU=;
        b=QUXuvZ8kZh0ndcw1nIPREwn+oeBbiCtzFF2p3hxJqV3T6VSpHszSfVx4khfyQA3Fy1
         b9LW7CrCDftAsXQvFptPTPnRMSHeFW0Yq3jRpsoBhV+OCzjRtVat3xgHYm9mLUPdFGOo
         wDEveaZFdNTZGok6Q9Mhe2UzE48+9rv/EBeuX8j8uvEh7hTrG/SvHJk3eCZTNylr1/n6
         ++EVIC/meIM7vmPkYNgmqLrue3Eb1ezTpwwJCNmel2s5U5STscnPUWdGtxLfVmAk3bk3
         fMnHtjC6ZjFUUxFYf1ZuOF4Ikk/3XKOsIMIhWGjdifV2OjQXJYRz3wN+blFQgtJweq7x
         rBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934850; x=1713539650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvTrRH4DLn5mnkphu1F/WSdXeIOZNYO5jK6aFD3PDrU=;
        b=aKSyqn/NQzijE5e1vNouODXJ5/P55P4v8rDjzAVFi1zEIvrD82DzMStwck0Ej1P2yv
         Ikaq1Qd1XqhvSBkVAwj8CIIxL8DsFj/hetyGRuUFalcqFqhQu7FPcERoCV2/TxpBC+/+
         O1dgehgvH9FDwf0kVNAnyy5hzWdmVqynnDkGqlpUchBkrZSvD1v6ShCJyv2PvxqNPI7c
         sds/SQIP1G0Nx1/cz4CyaKTyUOw4170S0fak+vvrJ/OfdgXrZefOigUePwC2KkVreGdF
         bs6UhmPw5E1h95bGIy32qv8bGGbqTTant6W530plrKlMThs3OrwCVR60EfkMlYq93/aR
         aolQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvZv44iwjYp7hU5BTjaxz0tXzyy7U0AhtUu0qmhqqzhtgqL3vV3tg4mU2Ap96VHqKj98iWKXBr91WPxcWL73Dvihhrqhll
X-Gm-Message-State: AOJu0Yyl01IBBigObB4PApMH2umzek2xgcSZoj2QQNK2M4/ClL9r+mqs
	ck3RdXc//6q1nlahBwS6+pDFBhTD20vJLWZzYserZ+hYYMune0UGASyaHdo1sn4=
X-Google-Smtp-Source: AGHT+IHPT/AKg/d/ITeSjzS7RN63iEvKvshdq8COmNXww3i51Ic+ylC4bbdmh16DhAGtcTBWhnP/FA==
X-Received: by 2002:a2e:a0c3:0:b0:2d6:a609:9a33 with SMTP id f3-20020a2ea0c3000000b002d6a6099a33mr2054630ljm.0.1712934850280;
        Fri, 12 Apr 2024 08:14:10 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id r2-20020a2e80c2000000b002d6daf3b41fsm513237ljg.101.2024.04.12.08.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:14:09 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:14:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Dariusz Aftanski <dariusz.aftanski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [iwl-next v1] ice: Remove ndo_get_phys_port_name
Message-ID: <ZhlPvx8YF3TR3yOV@nanopsycho>
References: <20240308105842.141723-1-dariusz.aftanski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308105842.141723-1-dariusz.aftanski@linux.intel.com>

Fri, Mar 08, 2024 at 11:58:42AM CET, dariusz.aftanski@linux.intel.com wrote:
>ndo_get_phys_port_name is never actually used, as in switchdev
>devklink is always being created.
>
>Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Signed-off-by: Dariusz Aftanski <dariusz.aftanski@linux.intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

