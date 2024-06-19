Return-Path: <netdev+bounces-104908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E555B90F172
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD6D1F238F2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC61D54A;
	Wed, 19 Jun 2024 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="K7ubQbxq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F2405FB
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809092; cv=none; b=NaPTAXEbt3E8CIeinBlKlQgPOaQ4nVoqqFMOGYOE72dGw253vNMMShuIER/7SBN4hHFF4KmsAdHqx6XLUsEX6MzKcp+o6oy7HFAwhF3NvFO5nfoZewj6ypR0HKSUCnmtlZ6behUdY/vxoOI91iAfcAmjDIgEevr4GjYOCU81dCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809092; c=relaxed/simple;
	bh=qrVVPzjEynBxrsEHQhktFhK1uyJyriLlK6XSMFj/kdw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YNlpOuZRYLfNXPcMeKdJBvIsBh8MeAjaTqqgkQgR9nb3LtH/Ysy8HN32t25ynBKpMECk5nGGrQi8Vk1Jfx7/nqhJcnYPuAO7hypkK+e7j9taz0gF/q7E1kYGEES7vyGpgIZTUyq/CrSseCV7S4wZDLPw2GkACW8gdlAZ1gboUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=K7ubQbxq; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7119502613bso93080a12.2
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718809090; x=1719413890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA6KTnuQNURB1QqcwvpXql3oYJbOAS/xh/FTDvEGntU=;
        b=K7ubQbxqy5+T7MuOSqQ4lUthl7oRe+5WSiA0ryW7U14xjtlkkDpDzJVFM4Eg2aHaOA
         0cnA43IUvUmBUpv9KNUYijuwLKQXrczuzobqDy7nm224F4mCVa3M5lDfgPQjWGRTDUUf
         a06YtWFgZvwgV0Sx09EOIBfJIVbwqjCTuCvyQ1bQXirpXttDu3t6/32NZTrKjLA8K825
         U//3Zws7fRYor8V8R87eFmdZr2yvSsoycpIDJJHh0X8ZpQqszsLPCH6t/ATJZjgaq92g
         0fePTI36Ks6H6El5AgK8lFS5srGqRi+ucCuf8bE0Z8k9nfjW80uJnT+6AnWLhUUNKGgd
         0Mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718809090; x=1719413890;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA6KTnuQNURB1QqcwvpXql3oYJbOAS/xh/FTDvEGntU=;
        b=ufZyfTK/UcJNYd83knsg5QH9cOs02xwSNXE4mcrHQR4XMCU6nIw+FVhrLkOq4SfNDe
         uJ8RtnQFcK7sdwXO7f47upn0iH3yGiAvdIWacDjckRtFSB50CPrlCr+/pyOzMnbX7ykA
         jugSu23p+/C+zQqtZzMtXJKsN5nA/CFWIC8c6Y7Tzx8NgEi8U1t2LRr7MfTVtHHzwgwI
         GhJ5AavP7mOSNdVN4Hl7Nydw8/Sr7abm+nAs7vZmJeSmgxzWirn2ZD4rr+4XV/R0vylU
         l4Bc6b2ThUfBrC3PIq9HpD5czX12ajrG2GwH0EvoD2NwAyUUsNt/6wdMQYdmnG8m9jsx
         dJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU02PsyajjfDnZ3oO1mQtSaRJ1w2B6L1JSxocWruQ5UtUaMTdWWp+guk8SjlUjsQClJmbYZ9vGbNrnqATkmNbXXf0rxYraJ
X-Gm-Message-State: AOJu0Yxd4/QroZ7fS5V+U5KIZ434/NMCzGq/7OQV17Bh0BPM0xeV74HJ
	TEc3Ps0DT2n8xIYJE/DlN93dJjLm3Hun4IIIhhm/f2UkH/yJ7OCPqhr/pwEXuMY=
X-Google-Smtp-Source: AGHT+IEZSFAdtIVp/yb59keMALUIWHqP1n/mDrav6RdQaOKTddLxpnp8+Xi/bYF2TqPHpKlGQXnELQ==
X-Received: by 2002:a05:6a21:33a5:b0:1b8:622a:cf7c with SMTP id adf61e73a8af0-1bcbb727134mr2796204637.3.1718809090558;
        Wed, 19 Jun 2024 07:58:10 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc9744ddsm10790861b3a.71.2024.06.19.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:58:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20240614163047.31581-1-krisman@suse.de>
References: <20240614163047.31581-1-krisman@suse.de>
Subject: Re: [PATCH v2 1/4] net: Split a __sys_bind helper for io_uring
Message-Id: <171880908975.117475.7297560909114409579.b4-ty@kernel.dk>
Date: Wed, 19 Jun 2024 08:58:09 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Fri, 14 Jun 2024 12:30:44 -0400, Gabriel Krisman Bertazi wrote:
> io_uring holds a reference to the file and maintains a
> sockaddr_storage address.  Similarly to what was done to
> __sys_connect_file, split an internal helper for __sys_bind in
> preparation to supporting an io_uring bind command.
> 
> 

Applied, thanks!

[1/4] net: Split a __sys_bind helper for io_uring
      commit: dc2e77979412d289df9049d8c693761db8602867
[2/4] net: Split a __sys_listen helper for io_uring
      commit: bb6aaf736680f0f3c2e6281735c47c64e2042819
[3/4] io_uring: Introduce IORING_OP_BIND
      commit: 7481fd93fa0a851740e26026485f56a1305454ce
[4/4] io_uring: Introduce IORING_OP_LISTEN
      commit: ff140cc8628abfb1755691d16cfa8788d8820ef7

Best regards,
-- 
Jens Axboe




