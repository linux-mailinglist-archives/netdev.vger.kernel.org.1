Return-Path: <netdev+bounces-145046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AFC9C9326
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 21:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86471F226DD
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF4F19A2B0;
	Thu, 14 Nov 2024 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqX52SMp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF531AA7A5
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615761; cv=none; b=hSrOJR9na+jsepUJGqwR8CAE2pazOy3xK73iIvcJnDkFCuWC1BdAuYKuq2Z5mL/kmWwSLUP9n3v0di7Sl7PGZaeszDqt53dVGaFTFxbYtojKr2cYa8DRQkUtTzPyZXY/0G875YPI/iDb08zSiU+IiWnKEvIyWwqENhJ0FXjyr1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615761; c=relaxed/simple;
	bh=76NDDwoKoBXx5qf4g0QNnDd1T/t+9WzVoNFrEBJFeAo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WqKs69q3Dh4OE2+WmP+pwpTXgwM+f1BCd881YOjNkEj1PYNNBuJsz+ba24vVyCdEkQbbBL8WEmjItj2J07wUk6ymrH3sh4i+kBzlo8FC2GiMH9lygvbXFIyTPkcMt/PVOHCzSTBCAfiyzpYaelXPthdFTpT9tLmBI9/ujslLbfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqX52SMp; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b1601e853eso62628085a.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731615758; x=1732220558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOlmB5J+6Xy6IyTceexxuS4n1USSRrI4Qc2Sw0owsjI=;
        b=OqX52SMpbSMnCbQ6cm+0YPmw9SGqxFXiTCU+gET8udBNLziKvQ94TUO0Gkg4uvaDI7
         ql7hZEwfkBrnIEq2cKYQCzRoB5stjIbM52k8bKGL3gP0awx06uT+5SP0L2V/C7HmMN7m
         Hpyi6uOYjquHeGrJhZYbR3Uo9Vqix5FVTFeB2RXNcoedXXt8elnmgCz3w7djkx8uE7wQ
         1AdrDnstHO31jl4TOFe1FZXIIWFb24Mpe96OXGottxBD5j52Wi+GTuCs1CYUDXV5YkZH
         ct7RLeMbDt4YJn5IPgDdB+WT1P1mw/+kNmjeVr4oWBnPBDo/4GLZXjIZglzDyppG46O+
         7tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731615758; x=1732220558;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZOlmB5J+6Xy6IyTceexxuS4n1USSRrI4Qc2Sw0owsjI=;
        b=VzNyYEvjNFD5pKq+zCzdgYb0m5HtmKXywGCKpFcJP9ClX01igA7th9K4ucBW1eVX8j
         t/rUd7g1OACrr1cP5KMhwaa57pjwwFCAGhIb67YGDhCuWPk5VYeLEJ4vO7J+ywP1kwEs
         sP61uXm6eug9giMbSuz1tBNI+xG1LCsjKWEgqKVIO59mXPiryCX5q7IzitWOaynFwnLR
         hY1+U8pFOUMLgMGEwEAdXFcGkW83dQbaPZUwgyfr3FZhsvPeo3BILe0cljAs1pAjVm4v
         JbPjttumtOYJu+QxQ0/tqUsF+QSoUGTU3wOqej8+AahZoNBC0mgg9C4wfnzrGROWKHs4
         R5sg==
X-Gm-Message-State: AOJu0YwRYWNACuM6+MzwoMrp2Vf2p4VkKvMe5/xKcqTt1PP1+ZSCtcyy
	PvwOD9stVI46j0MZWUxrUc+5yRHIFMY/jF8kXCws+VE4JP3xVayF
X-Google-Smtp-Source: AGHT+IGgNCe6QFjw1pwFKlAztZ1U6aTC+kL7jmsJ5wY+36xmNtAQ/2ZtQwbp14b4fQTPSooDBN1QRQ==
X-Received: by 2002:a05:620a:1910:b0:7a9:b268:3655 with SMTP id af79cd13be357-7b362330b31mr28732385a.43.1731615758592;
        Thu, 14 Nov 2024 12:22:38 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca50cfbsm86105485a.108.2024.11.14.12.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 12:22:38 -0800 (PST)
Date: Thu, 14 Nov 2024 15:22:37 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <67365c0dbd303_3379ce294df@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241113154616.2493297-6-milena.olech@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-6-milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 05/10] idpf: add mailbox access to read PTP clock
 time
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Milena Olech wrote:
> When the access to read PTP clock is specified as mailbox, the driver
> needs to send virtchnl message to perform PTP actions. Message is sent
> using idpf_mbq_opc_send_msg_to_peer_drv mailbox opcode, with the parameters
> received during PTP capabilities negotiation.
> 
> Add functions to recognize PTP messages, move them to dedicated secondary
> mailbox, read the PTP clock time and cross timestamp using mailbox
> messages.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

