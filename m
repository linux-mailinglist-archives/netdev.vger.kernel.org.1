Return-Path: <netdev+bounces-165141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D9FA30AA4
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05E2188225F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ACD1FCFC1;
	Tue, 11 Feb 2025 11:41:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4521FBCB6;
	Tue, 11 Feb 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739274077; cv=none; b=g61FcwF56lzm6clHBgDFOnorFavux2UE9/qi2SVR5FCPEESPPgZkljsiQ5Yid2UXFl0Gc4rYS42ZlrnqJB2MTRCEprsyiSIhJQNKF7Da5O/2pRxGGp7haiXwnXZkCZnMlOvCXSqodu7QRJ0EgRR2gAoLtIs3TaTe7idO/QOEF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739274077; c=relaxed/simple;
	bh=xJQgEYxd/OraxVuDMTxeLuRVzBO4dnMRncVH2Gus1gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZfdRv/UMmcKKsaPwysGQl41dWB9pwUFoG1vMtjEqY9K1cgQWQmQsxeReK3tsbkNgPpGzWm3z2WSPxmPPo9+208m2NsU20EY74X+/I8EEiAqdtIYkW4DTMv8A45HZedZlf9wVn9tKUbLeZ2XP3Cb1keg6uTUA6nGasJEJmXsURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de5a853090so6669605a12.3;
        Tue, 11 Feb 2025 03:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739274074; x=1739878874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlsBIw3Ft6i9u7USxcpc7lfwPifhSgzR5MZUNjLdeC0=;
        b=ne1kORZ98nTfzlqFWBeMCQEb04UTufkzX1STXMxroj8eLmKULqjg+PvNM4ROucczkI
         4AdPfavwd6ZGt69cWo6o/yNp91Sfz3ufSGZKz5Up/vlzFXIerUpq19S5w1o8bK1gv4ZX
         HZ3GmPX3FcNEH0j+YDwdLoeUbLSFlLWtUhiEhcMAueTyX+AlXvLqh4DpFfyEa5yGunqP
         XzCWFKYL1cGcGTP9HcPYZggL2nLalJ4sCo1gyNEAFZesyZFqaUevgxC+NcZcx7H+ZD0o
         x+8Sgf5gAdB5qNpl7R76ME2LG+/A6dJSw3cXdmuqJKS7fBdU3GBS4j/Pzh7lmmrr0TD6
         RwOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6XqPxY7a6RHDxKk8SoZ/XmDdChyyfDNTYojITlkW0TzlhabKBD2n7IlPGsqLQ6Z9plZELiMHCau5H+Gg=@vger.kernel.org, AJvYcCXxDiiQ0MTJr90LDN8tJkv8pRq2+AFkiTF08yXDe2iXcioCzdOxC7lfpMAZDTtcM3ExU+K6nryF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr1N1J+i5coRbNVDyQCnHZJHCzk2imlMXeZzFEoHdcqlAgcetw
	fG8Kr2jgQY4728tdTDNDP0oX0bSizsu6YiHqEw3jWwN6FhPcsUNI
X-Gm-Gg: ASbGnctHLe40lrjnGJeAcvkEZx9ipKWQmYf7GtAyMCd1JN/xqKNo+zWwy5TpKf3JUon
	nI+Cu30jc4sM1PdUHnfbiankvbFIjlgdXEjJ/t9U2vOM2OjcJQjybU4Qr76D0cX/Gkz4wmw75Tk
	H5ygmOuy6dL62ISxwIl71+hWfFGrzyabSWGaUlpDP6ZceNGnKn1nzU8QMbsit4jaTAZK22fNvK/
	5EgRiYxqgm78IhAICc3yhRoNqwKY+3URFeXTQSAUsZN9QjOwkGnHitPw5Gb+MTIetxiCulDNq59
	TI4PpQ==
X-Google-Smtp-Source: AGHT+IHXZk7DqJmmMgY3m6tlGWlq+8Beyt+TBALdhcbzMmMGmr8QOmKD1gLSFJWI+oe8BFqN9sCvcQ==
X-Received: by 2002:a05:6402:4607:b0:5dc:7fbe:72ec with SMTP id 4fb4d7f45d1cf-5de4503ff34mr14851545a12.2.1739274074009;
        Tue, 11 Feb 2025 03:41:14 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de63a89b6asm5649749a12.46.2025.02.11.03.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 03:41:13 -0800 (PST)
Date: Tue, 11 Feb 2025 03:41:11 -0800
From: Breno Leitao <leitao@debian.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, ushankar@purestorage.com
Subject: Re: [PATCH net-next v2 0/2] net: core: improvements to device lookup
 by hardware address.
Message-ID: <20250211-accurate-quail-from-saturn-4beac1@leitao>
References: <20250210-arm_fix_selftest-v2-0-ba84b5bc58c8@debian.org>
 <20250211010927.86214-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211010927.86214-1-kuniyu@amazon.com>

On Tue, Feb 11, 2025 at 10:09:27AM +0900, Kuniyuki Iwashima wrote:
> From: Breno Leitao <leitao@debian.org>
> Date: Mon, 10 Feb 2025 03:56:12 -0800
> > The first patch adds a new dev_getbyhwaddr() helper function for
> 
> nit: second
> 
> > finding devices by hardware address when the RTNL lock is held. This
> > prevents PROVE_LOCKING warnings that occurred when RTNL was held but the
> 
> Same comment for patch 2, this itself doens't fix the warning.
> Also, patch 2 & 3 should be net.git materials ?  Maybe squash
> the two and add a Fixes tag then.

I am not sure this should be against net, since the main user of it will
be targeting net-next.

Also, I don't see it as a fix itself, but a new API that users can
leverage once it is landed, thus, focusing on net-next.

Thanks for the review
--breno

