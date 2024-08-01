Return-Path: <netdev+bounces-114961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306CA944CEB
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608941C25936
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA260170A02;
	Thu,  1 Aug 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJTPWF8L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E21A2C27
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518021; cv=none; b=U2Hb7FGPcy58MTggzExbXc2Slzttp4AWwJ3eRusA9BBaXKhBNZ8DKDK29LijNxeKuGWpVqchIh4/m1VZOfTRzsoL/ZHl5MTdSHOl78MDTDtL/n29z4hIeajr3U4azI4IGPHj9MFIIKsyaNBKDea1nRsr3ZgN9XjazMsLRy8AIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518021; c=relaxed/simple;
	bh=845tkeAxz/ifi0uTSEHt0uuKrrz1V7p+jPLbZ9y4mjg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XVnqxr6By1Ie/N0x3788x0jG7urA0NT34pnzFK9nVe3Oir4EG3vKrJPwAq/yxzuGwpKnO/wcipE/XIhK6vESgOIlAtVWlU+O7v2Y/M0537Epmd3olsCCXldbLu2of7Srkn2zon8xfXCQFbhiHuSKyV3xwD5bGcxu/HKctNYJKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJTPWF8L; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44f666d9607so33249691cf.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722518019; x=1723122819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xsZqkDepUv5Geuzbxi9nE4O4ZzmRKotgNq8iX8atG4=;
        b=BJTPWF8Lfw4Cy9nIQ3qRcRrGMsOmE4cUt99gdJGsl7NEkkFvBkpJ0sBbkZFrJp77e1
         I4llyuesR1TkrWPsq4/7RyiJ8QoPtr+zr1aWbCb8oaRRvy+SmjUcx/d+ApsnjHHsUwAK
         WfTbwkrs+lgdwjAAXt1ZHiWAZ+YkSX9tZtO/lEkN1p+3S0hqR4AZNN1zlVWHE3vzZ7BH
         q/H4zJKZQ1/MQG7WEgdYdNH6vfAcmt3yHIDecsbSpO5HdLMO7PVe/Zyf5mV8wPc9Tq7Q
         07eOGZWoH+PioTT1LmD8tZFqDi8bNO++reBWshRnxc4sZbXHOZGnRYls1Eh/MXY9+zkc
         7pGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722518019; x=1723122819;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1xsZqkDepUv5Geuzbxi9nE4O4ZzmRKotgNq8iX8atG4=;
        b=QwoLydszwfqwAZnlPpA0V1XJBFyREzzVbCmlfW+bb7qVbfjsM+QvtV8nDfUFhlqLwn
         MZQyGiKazJLiLS5Y95BncVfwht0f28Wb9r07f7f8ZTpBA4K6nk7x6IoREM7DQC1qZv81
         3tI40Xpr+NDKjGTrz0PvdjciGVYTwSmROIQ6bpnXKZtMPugIoyrbRqaw2XPGyW3kiuR5
         o19AS1ECOcNaARMhBodWxXBEJmeZvv79hgDFrN3e+g70+FM8N5+qqhHGOXC6h40K+CP2
         YJIHHdGD4ObatAssPCTYFp83uPzN+59TnChTe/cvMhhZKsjzeAL1EFtGQAZO0/5U0TIe
         QO+w==
X-Forwarded-Encrypted: i=1; AJvYcCVTMeY403noCJZxci4jNIT0RmgAPPTceJUR3ZQk9faki94HeFwrEfBGrz3kVm9cNgjrvjwlMNLWcUjg0LiX4XcDBdvaawGw
X-Gm-Message-State: AOJu0YzZtp1BiDDdkVFbFuTlpogHfCYWjws6oMWpGt0QdINbp3wY9Odh
	gDzg+col9cHmVq2LpaEnj9OqhVbWYbz8BgKT0pboaqQY+doBBDYm
X-Google-Smtp-Source: AGHT+IHyqjJDpQjkJJhhsv0u2gX9RRbeRIAOI8aNNsZhVg0H6ScKxGpydeldUiakDlJn1VWJB8dJ4Q==
X-Received: by 2002:ac8:7e89:0:b0:440:4d76:a601 with SMTP id d75a77b69052e-4514f9ae1e1mr30485801cf.38.1722518019078;
        Thu, 01 Aug 2024 06:13:39 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8126979sm67285271cf.7.2024.08.01.06.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:13:38 -0700 (PDT)
Date: Thu, 01 Aug 2024 09:13:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66ab8a01d9a2d_2441da2948c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240731172332.683815-2-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
 <20240731172332.683815-2-tom@herbertland.com>
Subject: Re: [PATCH 01/12] skbuff: Unconstantify struct net argument in
 flowdis functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> We want __skb_flow_dissect to be able to call functions that
> take a non-constant struct net argument (UDP socket lookup
> functions for instance). Change the net argument of flow dissector
> functions to not be const
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

