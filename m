Return-Path: <netdev+bounces-145096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D1B9C9611
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D12282DEE
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3600A1B2196;
	Thu, 14 Nov 2024 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyFCRKkP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ACF1AC444
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731626774; cv=none; b=hYOoqP4p3pOQyEhedgWNBGSdwmtso8E2Pk8ygreCpAFXXeqB0/2iIAW8j712fH0sN8j7SEcraFTRUTbwr9jX036w6qxQOysfES6mNVN0G54B0MYah0f/3yzsi3Ef6PAQ9ZbHUEtww3zHIUw4fbzlNLdgZtotfmcTkSu2UKNE4VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731626774; c=relaxed/simple;
	bh=bOPKaUlONJ1wq4wSjmEJZF+oWJ1QGNAwG6Y/I7ui6Bw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ExYU1ZIzv2eb+66iWeMuuA7yN3vMUqjcOXEvWtioddQ71FmZPHBaPjGKc/980HYe9eTBo1MHqHW8YLn0ewo7IcXZvU5/bi6z/Ts52McMOZX13a+c7MUGtNchmpo6XFE4kjolsQRjmSARWFN0agInMn24IGL//jP1xZZNSbms4G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyFCRKkP; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b1467af9dbso75616885a.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 15:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731626771; x=1732231571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhLkdQ+5uLvMbCdWHUj9AfIdTKOYpSPlrqnT6ZPs6mw=;
        b=NyFCRKkPB9EUTWtZP18JDf+QHMyPmu6+zdkDMbsixzUucN99Zt30CA2iLA52O5YykU
         1W+Pfll7DEhWHQ4po3E0VzFlN4bezfRBdBG+XK609Nuibwzo3RceK9FwgkoD36XbRsDA
         nviil7CCwLQtA7lZLBcK2CzRrCrQ73G0HNq3lFxJkEkEaUFoxEDPAUpQkZp1VmNn5RIN
         Zz/Bd0E2EuR+1Vj1ZQDj3ubm2WDmRWuClzVuo2ILS5t2PSluAvzaDtsfD9cdiOJdKxkz
         9ZWyTO03Zy67hB0EB9Y62Svm72XnH81MbbiR1AaRcWgSQJfi3Bxu2SnZQxzBcbCow2WD
         Jh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731626771; x=1732231571;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LhLkdQ+5uLvMbCdWHUj9AfIdTKOYpSPlrqnT6ZPs6mw=;
        b=ON9TxDMPd5RK3XYnIhWutGT+/IJpHDe+M9neF0VRKLMUsVrOE4h9AQEZJ/C927hMgf
         sxOdF5wGqZIzKHIc6DXlvCT2qxeYWCZxpAO/eQFIOdGh3Sg6BINAaFgAiueY2y+6YK6r
         nR2k2eMTdnwlDq2EkBN0xpssVDFZtJxKuKGYtNUkc1RLm4Pl0b+LhDpk195FG9Fa+t9t
         ZIbw0h7G+PiLWAwEsx+QVES1jwKhKRTvI3I1v0Cut8a0PPWJkQlR5Vboloc7/Ye3hvAG
         LwyoeM8m4S9TXqDd24XEyXhzHmzqVPl0fl1vo/GyU4u2WYDpKgSNpihNBFzu/JgckgzT
         zqfQ==
X-Gm-Message-State: AOJu0Yx4DFBFyXmKsUPruSnMWBu9RZf4TIEICjnvB9zo7VdT4Z+8g6Kf
	FnMGLQGKhxWF82wN7ew7N+ltIt2Xl/pzR77YZzqErKA473MXKw/i
X-Google-Smtp-Source: AGHT+IG/B2pMZuR4f2b0W+RA/2nWmAFKOGJRYzhyrjS2sV89W1WPGEi/If/qKiNK3WYxCcoKumwlpQ==
X-Received: by 2002:a05:6214:390e:b0:6d3:f54c:e412 with SMTP id 6a1803df08f44-6d3fb77c070mr9376956d6.16.1731626771591;
        Thu, 14 Nov 2024 15:26:11 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee7ab148sm11141486d6.41.2024.11.14.15.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:26:11 -0800 (PST)
Date: Thu, 14 Nov 2024 18:26:10 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <67368712b301b_350fb529488@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241113154616.2493297-5-milena.olech@intel.com>
References: <20241113154616.2493297-1-milena.olech@intel.com>
 <20241113154616.2493297-5-milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 04/10] idpf: negotiate PTP capabilies and get PTP
 clock
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
> PTP capabilities are negotiated using virtchnl command. Add get
> capabilities function, direct access to read the PTP clock time and
> direct access to read the cross timestamp - system time and PTP clock
> time. Set initial PTP capabilities exposed to the stack.
> 
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Tested-by: Willem de Bruijn <willemb@google.com>

- Brought up a device
- Verified the virtchannel capability negotiation
- Verified /dev/ptp0 becomes availabe
- Read the device clock using clock_gettime(FD_TO_CLOCKID(fd), &ts)
- Verified clock is full 64b (i.e., not a 32b truncated that rolls over)


