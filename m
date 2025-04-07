Return-Path: <netdev+bounces-179985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54A7A7F08A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6D23AB7C2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF53224225;
	Mon,  7 Apr 2025 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTlkeV/T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7D01A3147;
	Mon,  7 Apr 2025 22:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066683; cv=none; b=du2P3MGm5yxI90JzcDEs3NKHZi0uaTityv9bNIOh+gh+Q/sFX7xmatZkk8bhQdVuE+Swf3FNlkRXwS/i3Wxypzq13VnUMX4LS0rH+hwSAFeYO3eFc+VhS3TZu/h97w1LzjTDMiJEF/pDOMmfQdkTIcgDMmGK5oP0oo0wTGkO/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066683; c=relaxed/simple;
	bh=aCun2nxWwiC2P0bTEkOiaBBZSp/A0kLQpyAdTs8QZw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnITDvCLxBRtIs4Jw1GAHWCeHOv8KPxD00PhxO3ykTvAq/xYAlk3+/3vl+wmTYf2Ks+ficXdkZxZdCrCqsKglgPK/HW1BRYrTIplkJxSWtLivBeOUaRkuR/k3zRoiZrB/dWnuA+CB3tQbT1PEt8uaxt9cjMTPuh4Ki6fdeD2Q/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTlkeV/T; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so3895064b3a.3;
        Mon, 07 Apr 2025 15:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744066681; x=1744671481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2kIoNVRerLOrI6+t3N2RYrXWP2c/BnoKh8+H4A4lq9A=;
        b=gTlkeV/TvzL4IA/0/fb+skf0GF3JCohXRtZk4kGtpnrMYz6LCwPlobTtfi+J2swZ24
         rQy4oXBwcL/vJajcr/f/BpBN6lEh/22XbDmilv7OwBm+pm+rCHr4C2vUa/5LEMBqlEy+
         QHsMWKuHhJBpXJ59YRoumVS1oDCbd67D41/UjOBE+yguHP7gr/dCB4YZKToTTfpb5KPM
         v9c+AXZF6WpJ2EhpUKkSwDgWK/QF7R89CtPKN6l4gYwgORGOmRcL9Ylrwm1MqYknNHqY
         ZDkfH8xx6q/kJfw+4eYyxkcBw83OPq6eUrCtIh4lg33m4DSVic1kVcV59KwhdcFOUqd4
         DBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744066681; x=1744671481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kIoNVRerLOrI6+t3N2RYrXWP2c/BnoKh8+H4A4lq9A=;
        b=pM0ZnFcf3WPl9Y8rckkl1EXxUrxInwEYewGamfdPUgjgp48AnS5BJnF2tAmxOXRmGc
         C8WiwOhjMijLBOQ0EuGMb66AivqgtUsrxdJ5S4nQ7TLhI0pXuHJcWyagQfc7sikTqQ4p
         mC3lYf57LCcD3Y7S6uEZ6zWdT9mJBYbGZN7VIYIM/bRATdPRb0wb9etiKgf8NOEpn4Zi
         YalneA3gMqGFbsQJ9m2Bi4h8IOTzOooO9dXOwt58LDrELPw4jg484OYJ8ieAx2DewEwl
         ASP9ztLxMvOhiR5pjMOXa504yOzI8wjcZvGuWWs6/wXjEzj/GV5XTf29Szrr0RD9qhY5
         DrWw==
X-Forwarded-Encrypted: i=1; AJvYcCVPIe6r5Kw3Zsmg7+Jq2WSnAcBWjfrZswksrJtOZxpayvhyDV5MPqDeDhTrOmq1Pxots/pBu03nPL49ZC4=@vger.kernel.org, AJvYcCXdhYdioACQqgAtqGAqcg4h5bzHRWVTsnOjl+NfrCS782bmPSVCYTSDtKPHC9QMbqvQ/SLPd7PI@vger.kernel.org
X-Gm-Message-State: AOJu0YwaJ/aKNxNS8K8BQkfgKRz+fvgP3/G90pCTMBTiea7E5Fx4Y5QZ
	TRXgDuh1gGbYIijPh5SXuh96Oj6WTjKg2LoGY+1tgUumzP05W/6l
X-Gm-Gg: ASbGnct0Jkegm4TqBaB9KsGSZJHLpLqSrnPTXrTERNwUXR9BJLIrQM/4Z8IIzJVitjr
	yybxSVZnzQO8mtH69JwKsgUs/GSXjxqb38ddjqtPyRgU5bedjttWIuUeZXgJSg1Gubm++v7kQZQ
	qChqzCwGN1WBvBq497wf2Pkd5V0LCc0h03Iyg/wMJi6X5RmK6ZmNgdbw3aJxwo3lPd5yGzHLtbv
	CofZTxdAyUimSPlLmEM6hK8BSt6+2b9IBxkUCVla87E6PqARRJMPqJ2lGde0vRbwY5HrT4Qflpv
	4f4bhT74HCY1342GaYGqD01ZvvhvKs1r4vvn1bR5hRc=
X-Google-Smtp-Source: AGHT+IHlvdxjQttnoqU9U3YAyCq+VEEtZD0xpiXbxleHACYxKayKaNgU5wZNpsOhUEM9LEHU5leFmA==
X-Received: by 2002:a05:6a20:d04b:b0:1fd:e9c8:cf3b with SMTP id adf61e73a8af0-20113d27296mr17555151637.30.1744066681233;
        Mon, 07 Apr 2025 15:58:01 -0700 (PDT)
Received: from mythos-cloud ([125.138.201.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9ea14f3sm9364515b3a.98.2025.04.07.15.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 15:58:00 -0700 (PDT)
Date: Tue, 8 Apr 2025 07:57:55 +0900
From: Moon Yeounsu <yyyynoom@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6] net: dlink: add support for reporting stats
 via `ethtool -S` and `ip -s -s link show`
Message-ID: <Z_RYc2R_Qf0xCaLv@mythos-cloud>
References: <20250407134930.124307-1-yyyynoom@gmail.com>
 <86ac7c66-66da-458f-960a-3b27ba5e893f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ac7c66-66da-458f-960a-3b27ba5e893f@lunn.ch>

On Mon, Apr 07, 2025 at 10:48:01PM +0200, Andrew Lunn wrote:
> When i see a list like this, it makes me think this should be broken
> up into multiple patches. Ideally you want lots of simple patches
> which are obviously correct.

Would it be appropriate to split this into a patchset, then?
To be honest, this is my first time creating a patchset, so
I'm not entirely sure how to divide it properly.

For now, I'm thinking of splitting it as follows:
	1. stat definitions and declarations
	2. preprocessor directives (`#ifdef`)
	3. `spin_[un]lock_irq()` related changes
	4. `get_stats()` implementation
	5. `ethtool_ops` implementation

Is it okay to resend the v7 patchset split as above?

