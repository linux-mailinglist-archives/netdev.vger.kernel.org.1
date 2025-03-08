Return-Path: <netdev+bounces-173130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80638A577E2
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F16188EF9B
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DBF12CDA5;
	Sat,  8 Mar 2025 03:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+sN1ikz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3471913C8F3
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741404824; cv=none; b=njjuPsheNfwX+/zvgGg3NAs1C/QbEf0lVkbhKodLhQ+drWSWFFmHk/5Kdhem55pbfV1QQYfElJVt+K0iyVYlGOlZtknue90d5tsSK3T8skXwtkAKB5uWha0DWZlEEkhbe+V7T79IlNUEeoJFEckLhGNpfU2Pwl+pEfG4DJhwpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741404824; c=relaxed/simple;
	bh=4PEh1mJIUnBxdLBuRUJcBOruCY5xb5ne5yALVVu+kEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvRAwkRNcrDxkVNjOdGRqiQZajQddh9r48e+6O5je7fo3W6LJbER20xv/DO//4jOJd4GuLzj8wuLDHqcQ0COELmR4s9mk/De7/WoZ6bpnfAX7eOoPLnfr9bF0cK0CBlG4uOhJgeLDgl9MsZn9vEcZA6rG6AnQX1E2LjkCPG+8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+sN1ikz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223a7065ff8so23896315ad.0
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 19:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741404822; x=1742009622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RUdJzig+QZPaV1OXxrKSicvU1IynWQXK+2hzHoA9ajU=;
        b=Y+sN1ikzGerVx6LPZTWA1x24587/h25+Hiw2+1gAG/PaP+pr2IlRGE2wAsTkg0VeCf
         FvilPtyCeRl7a+7CT1bLtrLULNewHGVOzIEC3QFLrAT+DimV4BJbTqe08lv5bDvS6V0h
         J75KFXlxrzoiND/uiVmWphhY1FW2ZE7HwOR7NU+PqHCMtq3XSA6lY5QJB+Ju/SMVnj+s
         DAjV+OexZIiZrvg6nCueMP8BR7hD10wvlVkjRzo3fJDy9ZLLtFUNRRe3qcg38jEAF/8X
         EcfXZ1O62gnknh5TgWnPnDtP8t/j3Z0Ia8jNW0WklD54/EX/JXG6z3FHmIDeitRZ02wM
         Pd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741404822; x=1742009622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUdJzig+QZPaV1OXxrKSicvU1IynWQXK+2hzHoA9ajU=;
        b=iMnYBKUSim/lx318eV7NVkLTp4wBTt/12SEKzkyBgkoQIJhOMbLbPoSaH9GmXw8nyU
         NUKrWBNBORo2vQ5WcV7MRYKs8jCjQaniMlsL3eFiaXHV7lfqjQoymkVfYIYaNavFmv1R
         rpUjGsuX7bu/oW/iTErKnD70rO03DUr7EM2T5mk5GDfk3guJBYhKuFXZ3Gp6j+V6lTi2
         yPyIHGoDLxo9CKu9uDY/cnFa3j8l295vPKd2oHIWytdehF33W62PU8H49/rrNq33D5/I
         5nIDet/20plfmzTqnIGhVuWbto8r7XIyDdvaUPgypNsmyAuwaDDJNXx3v+0ZDUhqLefG
         A9IA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Vv7Y2HosCBsNEh2KYG1AgLZH+Xob+RVkKT8hZ9IfrS1s5Xzy2yMFnybe5rYpcdfHeVjEAuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6jWw231hHiX9XAtdGcsFfFRLXnAURJcSFD9LIZkkMsKqf4zz
	ZYzL9/HL31Al6oSaPvAahTDI0Chk1lm0vDLPpdjkQ5Z2ACTBGf8=
X-Gm-Gg: ASbGncshhYEWv8a/kSYLP5mZGJdkQ6PMGZJDGQBdOEOzQAcgrjYNmim7hRKuDP+Jo9t
	esXUAWzp+eFJLAnMJdoXTnESbAU4uBVOXLvn4aANjrkz6FY98bkHHyFfid6U73mLgbfM51jKGJq
	7ayoC8EaJgHJqG4jwTnVNoxuCnfthW2m04iRcPBmJxXvNr1rZhftFYyjh3BXkwtEy8RhH8OK3FF
	xg38ZrE0OQOWsKYJtUNI7D2fBzwkR8PHD/16LkBU8FD6hzNQEX5dVUdE6elB0bkTppxRZShxCVW
	cTImmHkPhNNrP1uVPjkZBRvKidWJi1ppFdI0sYtfkwSJ
X-Google-Smtp-Source: AGHT+IEOE6afIBoqDfa36fzW84LJo6iNtN8/RPENRbB8lKSW6j1R/rHhmVztSuU5cpFJI5idrQAnug==
X-Received: by 2002:a05:6a00:843:b0:736:a973:748 with SMTP id d2e1a72fcca58-736aaad3d00mr9459140b3a.22.1741404822275;
        Fri, 07 Mar 2025 19:33:42 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736bb029402sm869170b3a.27.2025.03.07.19.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 19:33:41 -0800 (PST)
Date: Fri, 7 Mar 2025 19:33:41 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me
Subject: Re: [PATCH net-next] net: move misc netdev_lock flavors to a
 separate header
Message-ID: <Z8u6laRzRAoxyXH_@mini-arch>
References: <20250307183006.2312761-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307183006.2312761-1-kuba@kernel.org>

On 03/07, Jakub Kicinski wrote:
> Move the more esoteric helpers for netdev instance lock to
> a dedicated header. This avoids growing netdevice.h to infinity
> and makes rebuilding the kernel much faster (after touching
> the header with the helpers).
> 
> The main netdev_lock() / netdev_unlock() functions are used
> in static inlines in netdevice.h and will probably be used
> most commonly, so keep them in netdevice.h.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

