Return-Path: <netdev+bounces-114973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81747944D35
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05B61C21B41
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D76152DE7;
	Thu,  1 Aug 2024 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5n+AhbT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F8F16DECD
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519214; cv=none; b=azOzVS4q+5sv4of2/nq1OJ40mBPnwvJdqHdDuCxtCJlglarOoOJA06PJQQVb6raizRGg71AHNeDJFtj2GaYme1SuClMcer7yUx1TbcKCIHb8L5h2vE71q7/Mw4xotBLcArHRUZiYUz/DbEOxWoRFvsYSrmZ/3xypNiMrci0nbF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519214; c=relaxed/simple;
	bh=YKWbOVw+gUctdfA7petT57/dH8pvvl82hTt/D16zGyo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=c+3iGQTG4kRJVJa9c0YkIhIoksLpUl6UWRA7PLjAurhpy3rA8fpVatDz1K2vEe4XI/Pr/AwKKg4gGdbC3Qe0jDIHH81IY5P9T1gf43k1aBaJY8Erw2W3hsRnFMoBb0bCTVZIyC5p/0u7E6YZkbpAKVuHMQ5ZvSFC3R1WMT3Uueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5n+AhbT; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44ff50affc5so39255441cf.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722519210; x=1723124010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73HJknptdfF8L31YJqvsfj++MhuyKwcMm6Uh1xx/rrc=;
        b=T5n+AhbT7zjxUSY4/IFp0xU5oZSey+4jW4DKMf7MDmcfJTyNxL99QHvr/CJG0ih69Y
         6o7L5x3z3505bX6QIGQD20pPLGSFBU+ukToObYy2PMOmWhM8ev8czUq4aeaNLe+Q4fBR
         HYO5UBnSm/hrmHPI9dzPyplws3yVZOwAfIV6VJbop3CLdmT6cx36jXGYp82gHyXKKNWS
         k4/sXl7+5MifB8iH7scUizgwmozlNwVc4Xpx1QTdikP5qtXRpnNXui6NMT9qYRrtshQi
         Aw413iqa74k/Q8Oi4ODHb8Z9RqDFTfgLd074zFVpDcwu5RBZ3Y0vRywhNKH5PTXlWgG/
         wVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722519210; x=1723124010;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=73HJknptdfF8L31YJqvsfj++MhuyKwcMm6Uh1xx/rrc=;
        b=wZDlVArfBrri172U0ymH8QWJA1rJREZ3N4MA4qAQECUVBXIPMvG5txD31vkEhbEeW8
         gA5YZINuvn4ZLHZay79Qg/Nf+l30lr6xetVDX5ZzJMm+FDuJYPqlW5q1Z63V818Xi1K6
         FmO74Kut2+QfQaFxrBbDe9xO0nZMr4sWwpSc+yGdVkqSX4gc1Lc+bGyfPmghlfpUMe8q
         gkoWFz/RIm2AFZ1BSZ8G9OIdf9Flid9h/FgyXCcoiA2QaLhtk2C7s3v+5KroLbvzYxUh
         Brs4RkF9XnqxpjDqABSYxb5rCEbcnfpake6r7VIeJNxQe+8qsM9pcgUDdMMa8n20oqI/
         bdfA==
X-Forwarded-Encrypted: i=1; AJvYcCX+pzw6Q764nVLc7KgMabik+nZBWvnuz+iNiqZcBWkY/XU0MVdQhcMk5CfbyD2M5REgpMQlLmAcpm0fO8PLLCn6gCA16T18
X-Gm-Message-State: AOJu0YxmG93iMVkF46c/nz63PmQ5IrRMfj4jVNlAJjR4/4Rxwwkgz0N3
	v/VlWgFd5IW3XLnLapuhaJ+xTVZd7w7PyOS6NRXK9kvfZauJu6Jy
X-Google-Smtp-Source: AGHT+IEIX4dXYLkC7U356/eTkYsOGQYIEwogSH2Y9VdXZbL0x/iIwTEeUftgukiQ3YBx9uuSs0IxTA==
X-Received: by 2002:ac8:5d50:0:b0:440:5733:93c5 with SMTP id d75a77b69052e-45189327edemr309771cf.57.1722519210325;
        Thu, 01 Aug 2024 06:33:30 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe840f8afsm68921501cf.87.2024.08.01.06.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:33:29 -0700 (PDT)
Date: Thu, 01 Aug 2024 09:33:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66ab8ea915b81_2441da29413@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240731172332.683815-6-tom@herbertland.com>
References: <20240731172332.683815-1-tom@herbertland.com>
 <20240731172332.683815-6-tom@herbertland.com>
Subject: Re: [PATCH 05/12] udp_encaps: Set proper UDP_ENCAP types in tunnel
 setup
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
> Instead of just setting UDP tunnel config encap_type to 1,
> use the appropriate constat for the tunnel type. This value
> can be used to determine the encapsulated protocol in UDP
> by looking at the socket
> 
> Signed-off-by: Tom Herbert <tom@herbertland.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

