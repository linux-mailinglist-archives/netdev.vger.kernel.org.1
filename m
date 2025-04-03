Return-Path: <netdev+bounces-179090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1B7A7A90D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 20:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A35E18976C8
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 18:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB42528EA;
	Thu,  3 Apr 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyMr+DOT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C7171E49;
	Thu,  3 Apr 2025 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743703534; cv=none; b=X7fJf2DzpsEOP0oW/6pGunQLxpgSnFhURnys6JyR8fVkZtsNAQYGJTlC3twpzbDxiGC1nmG/gJqzeknyp33i+t4FdFFJkjsyvL99Vja5iPyyHM4Xoy3OiIDhXmW9amU5Gcn+H2ld3fvlfx4Ccvlnm/GqkJa+Tpp8MIBFF8zDIKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743703534; c=relaxed/simple;
	bh=OSIlxw/JlNYSrjfBNSS34lfG1ghonqudBLTdZExWEdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oy2WOurvY+fAPFAY9HkI/epknGAwT4yr1yAvx4BhvNSPdQTCvkO3epeUiTiOj2cpH+1MIse0ZTNytlAjtF8VZyPS4MKc7BdqfG3vnIL9xGUilbkc3ErIKf+xXeZTG4AblymcZISGaT4wyZ3B81h47ZETPUcYARklj8aJ0HyugmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyMr+DOT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2243803b776so18590875ad.0;
        Thu, 03 Apr 2025 11:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743703532; x=1744308332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSIlxw/JlNYSrjfBNSS34lfG1ghonqudBLTdZExWEdw=;
        b=SyMr+DOTaeglb1MetYzawnrGBKeVq1jRBQC9Zs/4Av+3FdhAPYo7WLQei8h2r7RlqL
         Io1pLbfLymZllN3W0f0cgkHgbqzO243x7YD31VQQSKgqtIRaEqAr1ZGI0x+miTJ54wif
         6FNCo2RS8GuaxOWfbCIV5J25Rr2LV/rTRkZGDsTV8MnfpbcBs6cYDwqi5D8O44z7JmBo
         meFwGM/KEZYxVimFQVTEZvr8oGmqlxNxUegZ3ys16O/ajkc67v+4b864mkhz9ZA5borZ
         Bg0mZus88I6n1cWkGfCLcPZ8hlAUP6BQ5/ZDWRmU4fcp4umZKDg4ruDQwjw5MFSAhEFp
         hbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743703532; x=1744308332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSIlxw/JlNYSrjfBNSS34lfG1ghonqudBLTdZExWEdw=;
        b=GWt1yo6As3jSS8+3TfGnXWa2uB28CiPPO0wRM53M2/qnsHMcJNgVpTt01fHl64upwd
         d6aR91Zt5XK/c9yr3dv9kyxmkGH3gpM8spSnhhu3vilPK33hYkbAqcY4wwxqcLzvbSpF
         ItYL32IJVWXmzfwnHSrPXNUdHcXKjeRUCsC926lPe30zMvzRFzPjrxdUrpbI/w41Gjs5
         Zq7vZG2P1LSLqKNm9nfPA9DJaDgHksGHz4K16NLLKdOuIyFsvovxtPFfTpIcqwZ2NBqr
         +Szt2XEJK5GJcg0lpmOgdONAJ3uAHCYS2yaq6HrEqdo94IOyJqldaMT0zKorwA0cY1Ht
         +PvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqfDMADt8uiUFHaWRkflwDaAf31KQIPnzYqOhN/AOSLnj02hNDlCNSLZpL03mpHT3SSMdz56eARxgOuA8=@vger.kernel.org, AJvYcCXbJkKTPLhXC4ilMhYxMRW+XdNzds5873wQ59NpmtLfKXOySugj46IJoJRZmUAPPGyKQ3f8OwMF@vger.kernel.org
X-Gm-Message-State: AOJu0YwgiX4z7y9pBC/dQ6IE2J7szEsX1odduGMvC8N6m4XKac4zrPkY
	fe0rNWee4vcEWUzVyP1MG+pmybjHLMuDNiSy4kAc+GWPsZ7Figw=
X-Gm-Gg: ASbGnctGvZRfakM7193YM8m4CS7xv090vStOSTPZXme8H4T9JaEAZn7iLSwqJ6idfHt
	hOMkGt2LpHOlIJPn26VK4n7b3eupF8M0Ifev71cKaygIw88oojx1VdDSAeLYKl+BrifVf9bR2D7
	99fiDxzdqLasYDjCZWrhzyy14HqJM2f0EFokJOD53z6bVt1EDzRPCMNcFHzjREFSejFQYDEch82
	V5Q3eXBQffc3/L39bp/6drbIXnY/LIayhMgrHncIG4JJsUDsF8p079kxLsaDqDW3nFX8p1cOg2N
	RUp2AkHTUj7x+F9nd8o5tTFDVnh5RS0UcyS0WZFqsOL2LS/VCLfTuCM=
X-Google-Smtp-Source: AGHT+IErL23saF+fSa8Z7JyTc/w3Be7817zaFvi5ASpq2H4qkfDiIYb6Af+QjmWHk7RI8h6lnHlQKA==
X-Received: by 2002:a17:903:41c3:b0:220:ff3f:6cba with SMTP id d9443c01a7336-22a8a0a23cdmr845635ad.38.1743703532443;
        Thu, 03 Apr 2025 11:05:32 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2297866e1ccsm17645105ad.174.2025.04.03.11.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 11:05:31 -0700 (PDT)
Date: Thu, 3 Apr 2025 11:05:31 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Ivan Abramov <i.abramov@mt-integration.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
	syzbot+1df6ffa7a6274ae264db@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net v2] net: Avoid calling WARN_ON() on -ENOMEM in
 netif_change_net_namespace()
Message-ID: <Z-7N60DKIDLS2GXe@mini-arch>
References: <20250403113519.992462-1-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250403113519.992462-1-i.abramov@mt-integration.ru>

On 04/03, Ivan Abramov wrote:
> It's pointless to call WARN_ON() in case of an allocation failure in
> device_rename(), since it only leads to useless splats caused by deliberate
> fault injections, so avoid it.

What if this happens in a non-fault injection environment? Suppose
the user shows up and says that he's having an issue with device
changing its name after netns change. There will be no way to diagnose
it, right?

