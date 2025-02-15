Return-Path: <netdev+bounces-166675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F204BA36EE5
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 15:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A563B13A3
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734421A9B39;
	Sat, 15 Feb 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzX6OTQr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E476D4400
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739631025; cv=none; b=NOCfjNAqVfanT98sX/wJSiZWaEsn+PWitv2ZShYqel5GZMfRmnDdlBnfeLStCT2vogavLpMW1MO8VI8/SliwOHXTPkBBJZtnVlVdtArGbGO3STBD0aEMAphHXbzPkJQu0Y2x2OG6/nsTWE1+CFj4AdTHHZKAMK3m9z9ndMa0DV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739631025; c=relaxed/simple;
	bh=MLuxh0yu9RxN1zLQcdqxyfGjC+/KO1QKHuJ30Hv3OZ0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=c+zhDkvuzwmfq3tqf+MN3erxrjOMqlf+/zNGbqqiKsk40gna7rkpihFf5zNjcGybygU5ZNJmxnRwrAIbTpIsYsGDbNJetezTZ+MYnAbP8rinhpLPcQcDnEARCdW6TfdFP9uX1uLob8T0PY6UvO6sqC6TAllgL8eQOsuJvzjCRPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzX6OTQr; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c068097157so380571285a.1
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 06:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739631023; x=1740235823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/q5F1sed79kdGTGUYcfdd53WuG7Sem+RPgKT3NE6KE=;
        b=KzX6OTQr79I1Iiq89wtLwqCGGlNK0OlACTg9rm5OUl1sTDUkecGuq0DyXueSWOJcU0
         8hg+eVQGNa+0rokppxevMWexAlrtfZTPNC3wbM9CuQ42tLnEZpUxEpPdIPaqlxqfJSKi
         3mbTfvLw9EnNkaejX1cN3I/+0oUO0ABpZaFbCtqMRqkvsrQUbxM6cOC5vkM6st3NOXXU
         tu7ogIiUqQ5YvPDdXLprXSnWqpIfTPEIKP0xxvhrZd+rfgNDQZszJZ3+hbxpnXc2txGh
         /u2SO5ZLfk3YtFjmLYEP4s3WfAxDdnEm+lhYhupOasdg0w46cQ0clw0p+KVwWryTUcVl
         PCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739631023; x=1740235823;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z/q5F1sed79kdGTGUYcfdd53WuG7Sem+RPgKT3NE6KE=;
        b=XRmU51ICRNTEApz/z+TKkwp0imeEv3swjTKHTJkheJBo8FfCKUSn42pHGQKHBVB2Lc
         OBBHtzOsxb3TMR48WCe0t8UIqdQWLfmJDCw1F3uGcH66VJHXOUldcMuO/RF3co425aii
         L/plBzKCbbJ5Rn/mjBxS6fwkCdsag/4A+CCR1kTSyX15zrsH4mmtFis/0q1/pKezkL+u
         GOO31miz2JTVRhicVLXGYmmsneJybtWBq10wNqPXQnaKNm1bjRkYv/fSuTtOdOM5+sgY
         6GU6YP9EzCg87Fr0qKahm76VsYPwGsUy+feHwLR3iJ2/IVzFem+zX9BXRs4u1W9jWDXc
         al9A==
X-Gm-Message-State: AOJu0YxQs9sGuP6GewNd1xV/0a/DJlu8Gj9Aq5hFXyAD79JWO8BEiuKH
	l3IQz4SxddxfwjmM2lUA8IepA/he4tMvYGqqxIerhnuk1cXHTrOu
X-Gm-Gg: ASbGnctMDXDai6XdSj4XbIaA0gZyGP+0/Tk7CzlCEhyqDycsgxwmKPkxdQ5uHjuZNEL
	xLced3aqVNfqky0zxQvbbdhb0fAl94laVEzw6sCf8deptVzNNVTsvtr0B7pk0FAentIUzPt0wE2
	39Y/Am6rW+Y8EYrP9SX7eYxKWuXonSFEyHFRcHHZFb3pb5rdf+PD36ZCKFZNxbgeZgImbSi+h5V
	ZPqaTFZTo3FK3O95F59QSqEJIBYSNiWKrVlyKEzyunlEUG2Mfv2/LMwTcYhBxPnzuvRayg35IZX
	JfQhHQmSNCCX0C//de7sZO7szyoYlXFRV/bzAM2MEgSkfyVPjSXzK+I9x7CB8qs=
X-Google-Smtp-Source: AGHT+IG6X9Yrn29Zt42uWvzKteWo259WpxlqdtuUy0WLOa65C6IxYshR+7RZhtpVWwwf3EjvV9NNLA==
X-Received: by 2002:a05:620a:4686:b0:7c0:7422:17d5 with SMTP id af79cd13be357-7c08b01c316mr500347385a.9.1739631022643;
        Sat, 15 Feb 2025 06:50:22 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c5f3663sm323146985a.10.2025.02.15.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 06:50:21 -0800 (PST)
Date: Sat, 15 Feb 2025 09:50:21 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 petrm@nvidia.com, 
 stfomichev@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <67b0a9ad6818e_36e34429473@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250214234631.2308900-3-kuba@kernel.org>
References: <20250214234631.2308900-1-kuba@kernel.org>
 <20250214234631.2308900-3-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 2/3] selftests: drv-net: get detailed
 interface info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> We already record output of ip link for NETIF in env for easy access.
> Record the detailed version. TSO test will want to know the max tso size.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

