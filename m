Return-Path: <netdev+bounces-200304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DABAAE47CF
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DFDF16351C
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2FC267700;
	Mon, 23 Jun 2025 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="P7wf07CI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844525394B
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690885; cv=none; b=mKGCX1EQYAYrKDVtl+Bwi8UmpJt+Wp6nKVMpU9xKQGt/d8hwjujzJPGyNdzCF1AJOSEAH4dk8rgrRvZDo4SmwKzJg8HsogLZ+Ld5m515aDS/U9PC94sEp+4Rq9mvHXNnUqapcYNDr2/mTX0iMpp0N9z2jCsyEiYZ8XXk8QQG7IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690885; c=relaxed/simple;
	bh=oWGurdLLaATQUzuTwWzIpzQUAFQvFzDZgQR1mTaU0w8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cntGOER0Dy26cV9az9iWA4Ax2wYoRPFG5JRUiGXhMDzLOr6oxmi9xWWg0j1T0jQK4nCTJt6jf6uUSGoeKdNPozBxDTGXui9NJL+CkVaqIPnuRm+VSZbZAWPZ9vaGbRkpzWdR3yaQhNgmXLTYbzcF9cqJTV/G6ivtUMRnVeKiz8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=P7wf07CI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23649faf69fso42744965ad.0
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750690883; x=1751295683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e12FTwFtz4sV1UkZylA7otkUya2j0xykUDCjLjiczB0=;
        b=P7wf07CIcMAtYSPpO2nnQqKV5DX0b/0kgKOD5nkhmRMt7QV8iADHNUzt442kKaMj3n
         q/bqkud80N4RPzOnpcvdXCxpmEbvhJmBcsBXsWx7oEYmtv8s4SRdmK+3VvAG1YYyf3Wf
         ztIdqx+gBQ8xqJq/cUIWeBe74tTcn/LXrxYPUSLG6yyPKMIgKEUPKkP2WQY5m6pHu/5y
         dl4IQzHQQZ3DiRGb8Bp1krXJ/XRhX0muwjy/uVyXp8aLSy5hKlNor2E3wlPAvV6szyC6
         A7mVCZIV3GoRlRYKn55InUBUWC3YSNwMHCNuW/ScrRCFo/01fC5zgLfVQxuPl59IBMOp
         iVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690883; x=1751295683;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e12FTwFtz4sV1UkZylA7otkUya2j0xykUDCjLjiczB0=;
        b=Tnd+W1Ipq9y2XNJ/oweViTvfc5j4ifjHGqC9i6Aqo3t9gChBao9juTiZx6xxkpnZQ3
         Zmglif7HBEvsOa64q6zc029EAPvPAfxzNLUg2ly/ldgPvf8PLlhn460X/NPWzlvP5kMk
         QgjGAE6E8NsYk6FOmbnggvLGxp2nCCEehVt8r+zKvUkA0OHIdhUnxGut1IjI8DGTzXV+
         DyxU11tyKiG8T/HUGPYS9QxUQUcFD7PHJ8buL4R+TaNPqSt+fManvwmkqSnh72TmR3cH
         +qWHCJbe3KEr99Ajc5KJ684+Tb24jw0lD+rNyHjgvxP6OM0DSjccbh0bF/9MRsvgoK3G
         OoBQ==
X-Gm-Message-State: AOJu0YyORqg+5ZbwD3G9Y5xFWFeGqVCSAA7JFdD0Q0Nk4mOIdJuQR9Pq
	QRu+WBhkKyWShOv9wc3OBySYBHHtF+mI+yGG64EhD2d1tVWsEXOXwv3/ZAtUkV6c5HM=
X-Gm-Gg: ASbGncs6824igyYwdHQSg1VQMo6EE75/BvV+bo45SIlxpUSnqFtdnX7D70bURvm2ANz
	7zg0HgSYDiW6XpA9O66wDtvaIWTO0+MnbUxUJiQ24hvC4/ytbZcbKvRsL46RYGnopigDPUftFdG
	KSrjByTq+aFkWhNqIlJPgPebGgnlxsDtASwd/SVao95APda1jnh5tSrZFPke6rGH1sCExqWt2oJ
	rzuCzn7hIB2w2x1GJHZbzCXwu0JJO//6jYVtylS6cMinA6yjeWakexxOUWh66Vbs+AMLjNNGLd0
	p3ANGOOrOyfMgZ3GVeaT2YcoSd6iC0aFXRW++QM2esau/Bjcy45nsA==
X-Google-Smtp-Source: AGHT+IGi8tgAngjx8JCTmimwDLIle5eZHSxrUUJ6vtXCGMkHWEBUYNEJ+ETEzVSa87f+OYzrXIsSpQ==
X-Received: by 2002:a17:903:1988:b0:234:ed31:fc96 with SMTP id d9443c01a7336-237d9954d67mr198312765ad.26.1750690883317;
        Mon, 23 Jun 2025 08:01:23 -0700 (PDT)
Received: from [127.0.0.1] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d873b5d2sm86886405ad.246.2025.06.23.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:01:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>
In-Reply-To: <cover.1750065793.git.asml.silence@gmail.com>
References: <cover.1750065793.git.asml.silence@gmail.com>
Subject: Re: (subset) [PATCH v5 0/5] io_uring cmd for tx timestamps
Message-Id: <175069088204.49729.7974627770604664371.b4-ty@kernel.dk>
Date: Mon, 23 Jun 2025 09:01:22 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Mon, 16 Jun 2025 10:46:24 +0100, Pavel Begunkov wrote:
> Vadim Fedorenko suggested to add an alternative API for receiving
> tx timestamps through io_uring. The series introduces io_uring socket
> cmd for fetching tx timestamps, which is a polled multishot request,
> i.e. internally polling the socket for POLLERR and posts timestamps
> when they're arrives. For the API description see Patch 5.
> 
> It reuses existing timestamp infra and takes them from the socket's
> error queue. For networking people the important parts are Patch 1,
> and io_uring_cmd_timestamp() from Patch 5 walking the error queue.
> 
> [...]

Applied, thanks!

[2/5] io_uring/poll: introduce io_arm_apoll()
      commit: 162151889267089bb920609830c35f9272087c3f
[3/5] io_uring/cmd: allow multishot polled commands
      commit: b95575495948a81ac9b0110aa721ea061dd850d9
[4/5] io_uring: add mshot helper for posting CQE32
      commit: ac479eac22e81c0ff56c6bdb93fad787015149cc
[5/5] io_uring/netcmd: add tx timestamping cmd support
      commit: 9e4ed359b8efad0e8ad4510d8ad22bf0b060526a

Best regards,
-- 
Jens Axboe




