Return-Path: <netdev+bounces-203438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08794AF5F2F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF654E3258
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636B92F3C36;
	Wed,  2 Jul 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyIfw+Rm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25622DCF70;
	Wed,  2 Jul 2025 16:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475226; cv=none; b=X3JrimNc+vFjxgYVW1cNRQSQRM+zfIyXrdlgkLtnttR9OCMtZiPstxuCyo25kURbZNbixO0teZcE//ugsD5/5vIWGGgr2NHTrmgzpC6o67Nk6Fuhq/qthpsF7VB4cEA1UuNvOUDceQOjEiHAGQFoNF7jcGTs0GH0Gdc9NewPSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475226; c=relaxed/simple;
	bh=TLZlQoXrzKidXYvZeUcSc5R6ZYCdcA/jrHikUFYN7wg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DdbBaJomqLaym+at+YWgRyZcNWpGEt2ZXKFTi124EZ0c7RrNKqCmTIwhKLgnrdCZ7+JEtZoVFXOBoONuTrjvudI5UDpqQAhtsRtgQDx/grzy/X8oFSCDXGL8jBZbAcYq9gdxGV9qcDsHuzgt3d7KJzEbD5gVaEIxboZiwaR8m0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyIfw+Rm; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e447507a0so39545027b3.0;
        Wed, 02 Jul 2025 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751475224; x=1752080024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOa/QrTh4e5OOwktHwb5ExLSFxYnfCuPCqHOntuBz9Y=;
        b=WyIfw+RmTIW5kKvgqLUlDnC1s312HmjWt6CAMGmp4wSPkCuvoVjh33GAsAVHCs+WQ7
         XFMJYgTO3LO4DJqmvpqAe13wumWH1j492DULo2ut/mQ+FNfpTENZM/mIF0ulm6lZDzgR
         Yt6MhtRCWgO4Mo3QdfPGdMGI+zluD26fFz8PPGjbqm87HQb7879TobDysaorol+snPjs
         OYADEPQ593y2JFvLPGIKb3XklMqRikTrlu7oZLVfb8pm085wmDctDMSFdF1RqdzL4NIL
         EP9CE14m4tsIeOG76wYQbdqVkz1wrEuuj21eB7PML1GEE9PGNbw9zCV2pgWYkOG9MkK3
         yp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751475224; x=1752080024;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tOa/QrTh4e5OOwktHwb5ExLSFxYnfCuPCqHOntuBz9Y=;
        b=LnqBY91kVlyhKJf+Im2IhcS9oYNVzr1WzPWTCXd6hyPZRrXOvlC6N7fJHXKRqRMmQQ
         NrK1BTA8h5VdL9ENpXJTbJuhJJaTlvllLPAQbq6Vr4nu7FgfuZ6Y1NT86+4Mi0sPAMDp
         3rT2vAwFNpNU22iCEOM7Eh9HSMCm5muAUSnDAf85TAOQiJH9UMH75admBFVEKpnWNi+g
         ZBMXRxD4DlbJSQL87qBXqph9iXoXyfO19jyaricVGCeIa3W1FY7a2fOANDSe31v0sUPs
         BruPNpWI6uSk+yJ+EF3EBcVLoC6S15HzAJPWoa07/5rNQ3WVzNfWltJtgDfeIIEeMSYM
         auCw==
X-Forwarded-Encrypted: i=1; AJvYcCVAZyojQRjahtjZ8o174u8tbUOW8kSPpHdi8yOTt72IYe7PH6hqgvmIrdNUxoKBSDcu1EbQSXtz@vger.kernel.org, AJvYcCWXVANoHzwq2IfFo5SL2jHw3Hd5BfSokaxKq9n9xSj+jIXOpt+vAjAFQIdi2VZs1R0Jv2LKpjSPU/cuVkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQCog5bQ0fsEdsujVjZBw4E5OeSukIbLm0wUKyhqPoZ//zwpzI
	ODA53EPy5r53aw7OH7lA/AlLQ8rfLq7hKHTQRVrJYXnVMOPKJzKkK+MD
X-Gm-Gg: ASbGncvg2U0cHeqq7lL3DkGkFGFqKiU/MOaVC65arfhHyoTwH5eW7wwjbmTNuPX3D01
	MAslE4LECTP1X2QOWb+LAMLd1D47rDx5BRdUyLBUCmSB/nbWGU9J+iTEMblZBJbTxuLpNSng6QE
	eAxetOUi3gMqHt7iZn3WESjnOoo0O0yC0cOsBzVTY/Zv8cwiBihvIZKC2YipxIs4XlOD21YoAdG
	VeceSNSuEjkmIbLTVBIwMvH/qej4WZ59pQf0diX5Sy3RCBWfk6HPf5fpozNpbwuz2cste6T2nJr
	woda7+Qbnqv6O1wpWsm/3pbAVXu5BKdhDw2IJ7VSOKbSNjsw5LPDnhqs2JSGv5/9kSb25KgzvDL
	oizemS+pSUvJQBYk8HdOOlvK7v5Fjy9HIBcFCUUo=
X-Google-Smtp-Source: AGHT+IGMx1y9Cl8oqZmf/wLT2n9eGQ6YOLEOgshmWcVz0jgiWR0fm4vX5N+r9OgKgYelHRoRrSfBjQ==
X-Received: by 2002:a05:690c:f0a:b0:70d:ff2a:d69a with SMTP id 00721157ae682-716590e22c5mr4517577b3.27.1751475223732;
        Wed, 02 Jul 2025 09:53:43 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71515c915c7sm25496477b3.71.2025.07.02.09.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:53:43 -0700 (PDT)
Date: Wed, 02 Jul 2025 12:53:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Fengyuan Gong <gfengyuan@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 toke@toke.dk, 
 edumazet@google.com, 
 "David S . Miller" <davem@davemloft.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Ahmed Zaki <ahmed.zaki@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 cake@lists.bufferbloat.net, 
 willemb@google.com, 
 Fengyuan Gong <gfengyuan@google.com>
Message-ID: <68656416d3628_25fe3329483@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702160741.1204919-1-gfengyuan@google.com>
References: <20250702160741.1204919-1-gfengyuan@google.com>
Subject: Re: [PATCH net-next] net: account for encap headers in qdisc pkt len
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Fengyuan Gong wrote:
> Refine qdisc_pkt_len_init to include headers up through
> the inner transport header when computing header size
> for encapsulations. Also refine net/sched/sch_cake.c
> borrowed from qdisc_pkt_len_init().
> 
> Signed-off-by: Fengyuan Gong <gfengyuan@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

