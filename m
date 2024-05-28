Return-Path: <netdev+bounces-98561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9A8D1C20
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A4C1F24844
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4891116C680;
	Tue, 28 May 2024 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuxyHWTp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071616ABC2;
	Tue, 28 May 2024 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901449; cv=none; b=F0dB6Yke/TtWdSuW73MhLy5RL6XWfSqlvJVatvUz1l2MhRxii2eRlmofhEcpYePuaAqmvExRPnrXEyiPbWcwTTr4jr3EKUGbgthgqpe633x+yxgBeb0675gY85l84j03eyOesK3ENFDgEzbyXajoZhr3IO0Iumt+DPeEQBSYlHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901449; c=relaxed/simple;
	bh=gAEKf8Z+F5p2sZQPDJyxTDvSbnaMUp24oyvKsHM14oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfSJCOk1deY66dVAJI1jZQXhxjC/bLXZwxM9Hn6Z4SxlRJiqa8y9eN4AGKBUyAK4wXYGEoc4uw87bWaOGWK54z768yyN7rgpex5tGsQhFDDI9qcrrDafon5X0maH6qkkNdUmtMoZOp/qMJKspPPYlYLhAIPxWvpxlQa7BIuri28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuxyHWTp; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-578972defb3so981771a12.2;
        Tue, 28 May 2024 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716901446; x=1717506246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXOIV4+qVuK991jOKcYp0npCSTU6GZlvpKHpXDNtUgc=;
        b=KuxyHWTpsCFWMz4HVl2j3J9qxfpiYqc/N/U1IJmn8XnhtFEnKcBonSbRgu3Tk1xqis
         xF+77MtOsIsEYaCepVgtJm0L2WOEPobxArHcqJ9HqXgN7nc9SFyC9V/UAHoPZpgULFhg
         EI+gNLMnQBcrNJf7VU4X/Dr/+crkgOY8VZM1nITMe1vFwCaw30YZSht4lUomLldRGZJH
         tD2NRxMei/bl8o0vuwlEpNHoxL9nGTtvp6Y3J261+ROGCQCZdoNz7fEM74Ebqqb+87bO
         AOOYc7ovaBkIqNr/f8sMv0duesCkcXSY4rbATB7T0N8vq5mNNDhOdHGDbKjmduz+EK9E
         pEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716901446; x=1717506246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXOIV4+qVuK991jOKcYp0npCSTU6GZlvpKHpXDNtUgc=;
        b=o7xpDczlwTU/CHTMAP4x6zix6eG29pN25pDzWt3hswtlYn4mhCMuj8uHi6CipzChC1
         w8zy8cDuj1s5yR7u/l53NJzMxD196jcJK0r7WFblmGtQhfffFGC1/x2rCrTzf9SRYMg3
         irasEo93IgjIeS/0hk22huyPssGiZyH/LVbAEONK/d8q/xGfAiRkaEYkVvi3bDWoy7+8
         z56uw5lKhw9s8rA+pQJoUIW4FDWvz3KjlR2svVpEi9o2gUIsODf86U1y4ALxcJ0hQgBZ
         9YXMCOcSUsSYhWJE+qcNyOTDln5SecvPYu9owfIU5Jw8e26LCKokkCBxWdsfTT4361NE
         pmvA==
X-Forwarded-Encrypted: i=1; AJvYcCWp7dYumSD9L0jvWZG6uNMjwp7BVrhzlMfd+3TzPypAds5O0C6ZJIDKFzeY4FAXVoS2AujaN4KaN8ltIVlytFpVvKsPxmDL6Fc4CZs2UaJ0DtiygMt9euR15iMmAQRmhon0ldDW
X-Gm-Message-State: AOJu0Yxpt17qOH+J/12EFL7c8KFwo2YXWQIawa4+p4q9zBH1anu+CnUt
	zR88hdfX7BtrffKCOgCOqPb77850pVwmxMguMyOK3jiGuvTTDWr/
X-Google-Smtp-Source: AGHT+IESrdIhLtzVi/G2Tg9eE5yLlAyPb2ZszMAvl2LCkGOLnB/QQlFURAPT0PzaWcJARBUchF9oew==
X-Received: by 2002:a50:ccd3:0:b0:573:4f61:ca9c with SMTP id 4fb4d7f45d1cf-57862e12a13mr6381459a12.4.1716901445833;
        Tue, 28 May 2024 06:04:05 -0700 (PDT)
Received: from LPPLJK6X5M3.. (dynamic-78-8-96-206.ssp.dialog.net.pl. [78.8.96.206])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57997181419sm4708805a12.54.2024.05.28.06.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:04:05 -0700 (PDT)
From: Radoslaw Zielonek <radoslaw.zielonek@gmail.com>
To: vladimir.oltean@nxp.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	radoslaw.zielonek@gmail.com,
	syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	vinicius.gomes@intel.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
Date: Tue, 28 May 2024 15:03:25 +0200
Message-ID: <20240528130331.21904-2-radoslaw.zielonek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528125526.qwskv756uya3zaqb@skbuf>
References: <20240528125526.qwskv756uya3zaqb@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Ah, sorry. I didn't notice that.
The PoC has been tested by syzbot
	[https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723]
	
The full link:
	[https://lore.kernel.org/all/00000000000089427c0614c18cf4@google.com/T/]

Radosław.


