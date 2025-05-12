Return-Path: <netdev+bounces-189909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F90AB4805
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 01:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FCC462C3D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 23:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BEA265CC1;
	Mon, 12 May 2025 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvGOMEdg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8817A2E1
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 23:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747093404; cv=none; b=Cqeh0ewUuQC1I7tjre90ActBnj5XFVJIQZfJ6EDtvzI5SyhjEmbA9MPD6DtPqA/rxKCfTUeuTJfB2AoM20H5SuWBo7qKsHot4l4iRcXv4Y3oIsyK+lWauoqtstnE1+CKfwDlPAOYLw6W0fE7iH9fC3fhdxo890abS45QptWnNiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747093404; c=relaxed/simple;
	bh=oZQGkCJXtzA6TSI2h8jnRwTgk9RakHbNqrDcQPx0ztw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUP30+kXUf4Rqp0JHuI8G1Q0p0pCVWOPqI2POdRqNTmV6CwBN6bnXU9rC7PdiFfKSj9tXln22L91ZPkxdgBUQ+mBctexibNPRRJPuGtMl5a1Ho0+83Bq9l6B/RKy/FKlNaYgr2IutmZJlykLVGTbYEX29UNZWPiGc1khFdEeCvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvGOMEdg; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b07d607dc83so4152405a12.1
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747093402; x=1747698202; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EdBX5Gz2Km8l9THJTLL2OFIXNI3sJU88nj4fjrGP0PE=;
        b=dvGOMEdg3Ru4LhXXOK/AMqICLDio99P8/ZAR7JJ/wSo/oOfEs8JvEqI0O3Z1qp++9s
         46rrkYuYZ3jaJpw6Fn/Mm32wbl8PJ0rMVzen+MeWQRLbOHwqpIGy6x0S1VGuRxoMEflK
         xDWUcIc6xbv0pZ1+puBVwy88WKnPi1uMPhbylyS7ntvkqanS5rJ8TUehUdb0hUuut95q
         Zf3v9H/tsbgJpie/W14MQ/UqNTHLdE8sjpgZpvj6R9mb5US6OPUfdcMzgFQRTbkcBfJ1
         f5tE38pH73AON5VVqVGr3t+Tiy5xnJpIlQu8apJJTgtS7HP2luEtZwTVjEFSjyqwGFJU
         5uHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747093402; x=1747698202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdBX5Gz2Km8l9THJTLL2OFIXNI3sJU88nj4fjrGP0PE=;
        b=R3nFpyWUDAfrbLBzh8asuTrG91XtkkHWhKhwpZtZazStuF09QsEz8IQXk5TTjlwhPO
         9826sEBNY29ngRPYTtwJCLz/LgyGDGaJxiW7MLK9IlcKAXfREVw6t077JcruO0c+a+Lm
         rJbyWxYUYKzYsZB/MlhXQ8txufeddRWAHK8JjR9G+BhQcCcCVaKIWkiHDQ3mie87W9W+
         SX3fGovwGh/WUR1Zs+Ms1eEeFDf84wJXhse1pKoLtqdkqVs7tl8EafgSwQSSYNqg5Lfo
         7IzV5joQbZNuQodKDX0zke8DTgvyVkpLl03gDQHrH+PNc8o7s1xyhtWwdjo1nZz+IMG/
         e01g==
X-Forwarded-Encrypted: i=1; AJvYcCXD1qLaC7gqTy6hNA285/3rrPTAyXosozT3q8dJZ4BM3zEtXz0FcaCOYNc/zVQ32u5WbIhKj/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJvry1/DPnW0RejT4jSznEpzX1CS1xFc38m93UarkteT012ImD
	rzc7yyCDSWXhHxkPTVeXrT6uvoZ0QbpqkHDmojgOFAQfoiZdENoCdOPe
X-Gm-Gg: ASbGncuyOl4ncaR1H9pK885AFW4RFHqAwwW+bLozewnZKgsD8KYvPB1v54s+n9h9oT9
	VAsjOGOflAP4IR3UbTxnztIBXCd2tA+9LtmQIyPs5JLcbqsIYXHMh1K4U2UPkygAYSlIAMbfJg/
	+6VNCGZhE0mnDM3t///tZHPYRtKuQNR2MrwGQIYK1df9etCqsxo7cdI3Tef+TVA/kqgzopcHfU5
	J7YgK3TjzhIdk50H8rrCA2zVe06WAdgIAmyjuNB3e/r47SvOL3wYzphTVvDWGaBapKd37r39iRE
	H9SN9JpSXRMtMFMid3qlBBBTZxJVrMQRmVm3WrFwdq8Bevjob390qbth6y0+9OiilKNvBWHEHPw
	g9BGk4UoyDa3O
X-Google-Smtp-Source: AGHT+IGsG6R9UbqGuH3MXofAI/0ChTCkr/96k52D1V1Y+cDQxk3dVWr2mBNqa4vKggb1SDt481IC8A==
X-Received: by 2002:a17:902:c7ca:b0:22f:c91f:d05f with SMTP id d9443c01a7336-22fc91fd077mr154676025ad.46.1747093401780;
        Mon, 12 May 2025 16:43:21 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc773edcesm69149195ad.71.2025.05.12.16.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 16:43:13 -0700 (PDT)
Date: Mon, 12 May 2025 16:43:12 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	sdf@fomichev.me, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net] bnxt_en: bring back rtnl_lock() in
 bnxt_fw_reset_task()
Message-ID: <aCKHkBnPmVwmpsh2@mini-arch>
References: <20250512063755.2649126-1-michael.chan@broadcom.com>
 <aCIDvir-w1qBQo3m@mini-arch>
 <CACKFLikQtZ6c50q44Un-jQM4G2mvMf31Qp0+fRFUbNF9p9NJ_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLikQtZ6c50q44Un-jQM4G2mvMf31Qp0+fRFUbNF9p9NJ_A@mail.gmail.com>

On 05/12, Michael Chan wrote:
> On Mon, May 12, 2025 at 7:20 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> > Will the following work instead? netdev_ops_assert_locked should take
> > care of asserting either ops lock or rtnl lock depending on the device
> > properties.
> 
> It works for netif_set_real_num_tx_queues() but I also need to replace
> the ASSERT_RTNL() with netdev_ops_assert_locked(dev) in
> __udp_tunnel_nic_reset_ntf().

Sounds good!

