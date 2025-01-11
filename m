Return-Path: <netdev+bounces-157430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E7A0A453
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39DC3AAC75
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16C11AF0C4;
	Sat, 11 Jan 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KC/NRUq9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCF7F9
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736607553; cv=none; b=Fm22goZwcsBpNi7s0w3dDLLhhOSc/XPrd2NMk9xmGoy+4ZYNXmjhhl5QaZ0ygCvGs0vNL2IAQoD6hWKQZKPc+kv1FhzG4K0hTMYasD/a7Lw5FcsQD0ho2VPBVbueYZAa29iOET8jlKXCjBKg/N26X45ppNOV6vTHkCZgviqfiQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736607553; c=relaxed/simple;
	bh=BZR34EIDPrbJzPucAGQa/CSwplGSiWcz85nDi3zKWRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMIDXm8FbD4Y5EKC8wLYm5lapI6GzaXmaMsZkZeKW5nTM9kZVU4ruhLElsS1CC1RH5TJ+DoRLcX3mhTBcAtRg2B1cITQYYPlgoLb62qQf2wzZU/408k/VUhD9koWwyBroiUc+8B79lQSlVxzgBrq4Lc1YwtWjgAbpSAzljcMNFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=KC/NRUq9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso4030866a91.3
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 06:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736607551; x=1737212351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BZR34EIDPrbJzPucAGQa/CSwplGSiWcz85nDi3zKWRE=;
        b=KC/NRUq9//goNT1yC9jj2VrId+C8w/zBGh816MY9yL3KskwJ6jQQKUKUhABpo3D4t0
         I6GuR2yqPq5w+hifPRXSHXpY+hByQk8B9kV31r2BnPQH179+7LYUKKPfiobH4Ft3myQb
         pg3WV6smIuo8i+W6Kol4aM4Pqse2xra51rJbc1f24p14UomjLlKegYuOUOo+hJ4DODK3
         55bgeGmJvW8k/o53EgHXD0XN05Zrqo2I6yEvJ8Y+3pUTnBESHuALPGwIGLomYRs+5pdK
         d9yzUOUVMewOLW3kh8379uNZhjWqo9H5b0asc5bt2YKK6TU2GrD1lV2/V6gO7Ys3xqBY
         s1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736607551; x=1737212351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZR34EIDPrbJzPucAGQa/CSwplGSiWcz85nDi3zKWRE=;
        b=tvJUvMsihPggXD66HyVGEvb//Twb7dGv1R7C4k+Jbh3GUlGGhqVL17aN9aqqEZ6cfr
         nu9Y4L5peVsKTHEPBexQ0nI5wfzosm4WtExSkFNDrL3/OSu0S5KAUQYGvOBh+S7aB7IX
         vtkia5yZpoivucpI/NWDS6ju1YSWIj9zalQ8DC2uA1LExJMGYLBS3nrVuYMfw72dy1W/
         o1fdeG5g8PU4gofIlJL+khnGcL6XYMk9XuEL6Xivg7/zcMPI0oEYFCsdgrZb2YUNkLDq
         88/oXTbh4ffxvVTm7iArlGtZdBfSrpZQ0jdruqq/LCqLXoryESBupYdZpSi+0SkQmn5o
         NQkg==
X-Gm-Message-State: AOJu0YyWDlQmSvZ5hfQooUSLGzTgKVXyrwt2WbxDEVUOZ3M3t/5mAcl2
	0E5WnzNSVc5YXMMqquNJ4VaHzKtjAKJ8AXA0qGy8mMoCjAAb6Gyjte/Z24Ctk1wGdNTNq3+Oq03
	0TWSU+rIT1gjOEUXzQOWv7i8rwJSBQG0rd+d94GpdW8ccOFg=
X-Gm-Gg: ASbGncvdVJnIPWUI+qLGO6Tf3eySqlI8CkflxprosPknxPCgwagZqxjJsx02rMHNfdf
	JhStb72jlhTISqSPNFtp2JqkvmHTB2hzsxqkz
X-Google-Smtp-Source: AGHT+IGZV6PifkhOtbiQttzJhJ8JhDsi3iyViKj89rv89VVmtWfR0YrRwqqg4XrDuYxD8kDA5TxY4MTzNe/0H9QYQ5k=
X-Received: by 2002:a17:90b:5146:b0:2ee:bbe0:98cd with SMTP id
 98e67ed59e1d1-2f548e9a547mr22143059a91.7.1736607551164; Sat, 11 Jan 2025
 06:59:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111144658.74249-1-jhs@mojatatu.com>
In-Reply-To: <20250111144658.74249-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 11 Jan 2025 09:59:00 -0500
X-Gm-Features: AbW1kvavBujQ6VvHontU14MFLFA-xHtPbqaHN5G4bQMt4dDtrXH1Qy6y3jkio9M
Message-ID: <CAM0EoMkzbawQgC3R4tu16-LHiCK_gvtb9GmUX4kYtxu61SoQtw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] net: sched: fix ets qdisc OOB Indexing
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, petrm@mellanox.com, security@kernel.org, 
	g1042620637@gmail.com
Content-Type: text/plain; charset="UTF-8"

Sorry, re-sent V4 with Erik's and Petr's reviewed tags.

cheers
jamal

