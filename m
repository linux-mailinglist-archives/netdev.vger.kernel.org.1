Return-Path: <netdev+bounces-134741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA0799AF67
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528501C218C4
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4BB1E2000;
	Fri, 11 Oct 2024 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqybl2zj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8671D1745
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689373; cv=none; b=QfImJTKxrM7+s7854nXQ5RHhyJq+0GwVPf6OkaQw5R1kPTJqbEQqMbywLCkxhkQn/+jy5MpRBeIiUD5zrV/YMs0rzoCk9rSI44XJttt5CWardJVbt6xZHWrtmK48zO5SJUAYyZ9YQsq9xWu8kbJ6VmqDmH7bPBw2YFoGv5gFl9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689373; c=relaxed/simple;
	bh=S/KWHv2Dg7S5envgqwKzQnWRqfz21LUN2e1C1CwX9eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWseYe5Sx8CXS3GQlgTWlGUFPSzPPzgUOM1L9jIkMZlTc4dyrJfI5kTfO/kvNfR3LPuUwCMehe6xpQWE82RCohFebRR/rUERSZrG6k7FzyAbTayudiGZTQFSMTnCnQIuAW0a4rISL1gOJ5A+DTM/gMVsjm6CfhQo9qTmgoikOqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqybl2zj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e9fd82f1a5so1694048a12.1
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 16:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728689371; x=1729294171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwGO9jpN3WnYsggHk/Z0Tv8PMDqNHB8vByfcdwUXSyY=;
        b=dqybl2zj/v35SO5NA63Wrko1+hHa4xWFgQ52pD+SwxU81g4YSvIo9WMXZ4c9Sm4u24
         765QnXhWaTSNA00ZYian069OboRL++ysYK77cb25JuKFV1uB2lR0cFRBJE1QDaEbH6wx
         1c8KxUwdZzkgtJPtce1Bmz7rcxcV5B+DUBo7/NEta8nAFR2lErl+Hpj5tGdP44UIDEgG
         QjzlOlnX2RZYpYWWCXOUfzpIq9QAWYRH8MKhlk/VMc4IEjSC1cVaj9OH+fEuVmMoWWS5
         eZ9egE7TLmUwLfJlOtReBB9tvqZyUxZiP5Vklb9gzohtEvX4RBsC6skldL0jwBGYYHwU
         8YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728689371; x=1729294171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwGO9jpN3WnYsggHk/Z0Tv8PMDqNHB8vByfcdwUXSyY=;
        b=Ge3m9/HGSDLbi6YbBiVYtQkPE6FlODRRdsrMp6G4d9gu7DOQwJ05v+/uWz8BQsjbT8
         DAGvwvclZ/+2QiDe8LV8ZPv3XnBde291NqQwNoHLNn+Hsfo34fSXudoOaIjzRtPWLFZb
         EEooEsYfbMlL2VXBrNUsDhbS4/uKtiHrQAAm9Cxh4In834eu/dtvDM1ZqxSyMKkQalWi
         VUWx5/sBqoWzd8/2OSpxrUNyFlPckiZlUNZeKiqv2P6qA+F6LNDN5xqutOH8BOjwkuPu
         TeoZq6oN8bPKUBuhTFvMrS8FR8qbfV3zSwdvZIqXVDhh9SxUdMspiHqt/TgfjWMSixaT
         eFXg==
X-Forwarded-Encrypted: i=1; AJvYcCWVxyPf76EDw9wAK8RsbCacJ6DK6hMIMlySFzwSuLZwpZh59DLbfKJzPdLv1Z23HuKg6D3SdZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQjMgLnaQ1xSTGCnY0cDqkyxtGnrDhmBRZdcO3KU/RRtIDgiNE
	/ZMcHKJmwrykKOP+19S0cPCK+OaznoHkCYoUl8IrbLTDroxy2RM=
X-Google-Smtp-Source: AGHT+IGG9JX8l6Vuz2OvKxCdYP3p3U7/cT3E9aJFka6KpFlfVnouPseDAgMe3o3mjeXWYVu1F+674g==
X-Received: by 2002:a05:6a20:cf8f:b0:1cf:2293:b2d7 with SMTP id adf61e73a8af0-1d8c957c1cfmr1545211637.13.1728689370780;
        Fri, 11 Oct 2024 16:29:30 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea44908ac3sm3032750a12.42.2024.10.11.16.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 16:29:30 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:29:29 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com
Subject: Re: [PATCH net-next v2 2/2] selftests: net: move EXTRA_CLEAN of
 libynl.a into ynl.mk
Message-ID: <Zwm02Wb5yUwUHwT5@mini-arch>
References: <20241011230311.2529760-1-kuba@kernel.org>
 <20241011230311.2529760-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011230311.2529760-2-kuba@kernel.org>

On 10/11, Jakub Kicinski wrote:
> Commit 1fd9e4f25782 ("selftests: make kselftest-clean remove libynl outputs")
> added EXTRA_CLEAN of YNL generated files to ynl.mk. We already had
> a EXTRA_CLEAN in the file including the snippet. Consolidate them.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

