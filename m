Return-Path: <netdev+bounces-184122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B531A9363D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF254482C0
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F22749F4;
	Fri, 18 Apr 2025 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUnSaVUF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5802741C2
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974003; cv=none; b=eDZhBwYIwcxcTX2WEiC1H7GB1hWJKeezTCR1GZyXhJtB5j+Tbbedc3e1Odfh8pc5m7d4R83w6Xn59FBmthAzcatEX+YS1UjQJhgfzZphcWXJPopYEf1eeULROunn7am2hh5ho5VLFoc5u/QlAFWHuMg+sxW0s/PA1uhNTzmCtjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974003; c=relaxed/simple;
	bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=LvYvpk+DSHb+VA2vTNoYuTcQGf16rX9hwCPTXK+tf+Nbk8WmX9nKbJ01GRrnqhBaiRmLc8xcbPoa3qfNFkHWotMa9JYQuIiDt7k26yuy3E5MvShKcKV7tUVl8S4pAstSm+v4fHRdBFlZfM8o+L6Baaoy8I6rOFBIU+kh1xudevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUnSaVUF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so1649287f8f.1
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 04:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744974000; x=1745578800; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
        b=iUnSaVUFPQ2QVaELP4KYXbbX6DGjfrMnnsISoSvtDBXV80WjMsoTj+njVbp+FXuGrP
         J2whFt+e672Kniz9oC2QMtuV0JbNHDhPIIJeaKzFsOm+/VCk+zWXKWThFoLbKZTi5bTM
         g89ZBVglpBgDsc5g/dTIAyH0Gco+6sefNnPbQVoehr7QQyn1pbtWfsITGqJz9IVdRdrd
         Aavn2NvIoKFwz9TgEOORFHCyAqEy2y1qjQdtILzQSpd7jt0+Cmmu02Y4CWddpKMMBzNC
         A24OZxpChqLYbX7Fsqn+Y02f9NIEzQ1tAOQKxvgf+rlpg5dgKs6A80zn5YCSqFb2SAsD
         VmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974000; x=1745578800;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3uJCSu701ZlGzEn+tFf6EfBImvkGpn9wJSSHO6qTGc=;
        b=QxgeOqJ113xgh4GDpyy1JpVJFv60Dj86HTWCemuASWueqZ9yW9dcqfY+t/Ablhb8ZW
         MgOfSgooi8N3ruzejXxOWxUDhfSsDOhhGdTBAPE7M1Rn9pEqbFBVrFf7ozPEeM31VoKi
         ae76cTdwT8RQszwpyGTXbhhUMov9Y+ZRXXjJFRcekJk+i2TBtcuZnJDgc06nECGGl7wx
         39ID/ItUbpmbqgcrxE9xf52b1PW/mMGexefK6ueX5rPkkEatBFiJzNDqw7/X4tvUecF5
         VMVTHYrKcyX+2apcn2FNLdJZ0zT1Ga9sRigNpbMGVKzQjWXn0KrRdWzZzRddZe9CHJ9E
         8JzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIAoRjvohxudbcyY9bpIXH2BDc1f0/+AxvNful5YEmW82/eAXkNoCoXTBx35MRv2szIUpvjBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN1jjNfO7/advaPaHeQAfeL1mIiT0JtpVvmjSjqKnE8F5VQ0Tx
	lUP8lJ/PcMgyuv6SrSEV/FEFTMIiTVyMn3TghWxUdwnzH05kU+1p
X-Gm-Gg: ASbGncvjVjyfu8Jr+J88DIGe5UvQSPZeBEVi5A1p6v5AfqFrSFbq3VFlZmrUzFAurY5
	NPdyLNhOlHC7wCgOZJxPtrklMWOAzUc9RtJKRORE7VOxs6nAHM0kJtJmbkVDTr+m3ms7xzW2AFi
	Dn9+KzR6kd3b+5Wp984mma6HU5/IE70EkhxXgW0jOpptn7++baHjIi4YKru01AwQ0Ljs96oTaw1
	3VZmG1aGTsYgoh7YHQSHMqLPmnB/KWiHilThkANrm0pMUMWAD/eFDb2D8KPQawktNw10DIFiy4d
	4YIlIoeHT38glKw9y49rhSMrXEtHQAUhFpzIOcR7mv2SZwexKnu0fmgQOAY=
X-Google-Smtp-Source: AGHT+IEcxDzQMv/4yepDvlBX1DbNgfjv+34v3bUsCZp9SUz3QjpvRElh1fsHX8Uckw5qKKoW9Ku/oA==
X-Received: by 2002:a05:6000:4284:b0:39c:2678:302e with SMTP id ffacd0b85a97d-39efbae5c77mr1901676f8f.45.1744974000014;
        Fri, 18 Apr 2025 04:00:00 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:24a3:599e:cce1:b5db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d6db173sm17535095e9.32.2025.04.18.03.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 03:59:59 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 05/12] netlink: specs: rt-link: add C naming info
In-Reply-To: <20250418021706.1967583-6-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 17 Apr 2025 19:16:59 -0700")
Date: Fri, 18 Apr 2025 11:36:52 +0100
Message-ID: <m2sem5iwmz.fsf@gmail.com>
References: <20250418021706.1967583-1-kuba@kernel.org>
	<20250418021706.1967583-6-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Add properties needed for C codegen to match names with uAPI headers.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

