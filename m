Return-Path: <netdev+bounces-254502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM/YOPOmemnF8wEAu9opvQ
	(envelope-from <netdev+bounces-254502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 01:16:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C521AA31A
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 01:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 754663012C88
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 00:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC852211290;
	Thu, 29 Jan 2026 00:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6yvK9YF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3719DF8D
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 00:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769645807; cv=none; b=NbOPfTWjpaJR6My0K491GloSlNet4cxAUkEtT7iziv2u05MZvfqYWccUZ5OrG/ySk4dk6j5imo8rS7s5hAQDd1mHZDxT4CusW6Lnx+lmXfmyeC0QM65KzRJKItwmsLBmOWu7rFYQsCGjSz1eIMgWNO9ciqzk1lgNcTxu+UID+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769645807; c=relaxed/simple;
	bh=XGEvNXM2iKXisIn5OfxXQA9qFgekEDQi78U9qzlY92I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KzqwirPw0FPUxJV7fxsenIEcSGLR08mFSgUA6S3HgSSyL3s/P6vJycxE3pGFpMXM4JuMWrq4PH7ZEgX4FFMsb8ycd+tpVkuyCnM+5m120h8Ylc2fP3OUjaF3fKtir3zJuNP1VDgrWZThsv275imxJIkQhpLKjdKKuCzxWc7wt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6yvK9YF; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7927b1620ddso7184937b3.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 16:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769645805; x=1770250605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN+YP6lavN1tEoFlcIc+efr+5b9kpYvL5aRTw+Pl/rY=;
        b=S6yvK9YFtNGloeSfjwuGGsjtRnvPy611vT8IrE4PyMf1vM0gs2YCNBtGf+6T/4QtKG
         NxIQWZs6RWbk46+6JvTgjqzV+A929P7LH/h7+GZYFQsASIYy83xTBdCY6R9RrzTg8V+z
         fwzRpDtUq7+R5f7Nv/Mcptl6/cTFTF6o6N6DS5VD9yWMjSdpIDiWWWhZPcwxjM9MY8kq
         S0XmkaKZ0vrv3nLNlsr96La+8L6ntmXWLvPAY+6JdEHNZznzMLPhY5FdcLNbGHR+GHNt
         XoKcVI8f9b1n066/pu1+17yjkPIcz+B1W/DO0Kvu1HGtgPi55Y8x74f/1N+3wV27FUvD
         /RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769645805; x=1770250605;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wN+YP6lavN1tEoFlcIc+efr+5b9kpYvL5aRTw+Pl/rY=;
        b=PyA4apFlQwG/Nx9v4hoFidcj2B5j9xKJqCm6QcRMy78Lx1hEKCLHQDoRhwMfnl9F3I
         aLgPcEjJyI1z01pLeBIETW52R6FWqyCRdLB+EnjJNhhCRREwqA8ZtEm34C8iEctCS/Vb
         TvhFgyej5012DlsSYvN2/17BQi2akDNrzmKnextSCKxboZ47KWAZXqntSdSUkxDhZ8Ac
         X6fsz2lZss02i+Y/aFo4qpGQHG1wKO0nstCUGH4m1yjKAAOhr1WYrv3QygGtA77ufy2X
         uXPsYtGo3NFeCJ71+6R2dwplN3C44C9b0aT3aYLqtcyIUc0ClyufrvQKITOzuWG+EUPT
         AOGA==
X-Gm-Message-State: AOJu0YyKdHUa25PmpV3S35+fREV9TdTpJbP3y7Pdi/5ravy/csZrKla1
	u3CrUuZ+W7gM/Fq4grSwa8RrS2l35cOtzSBlTzM5BKHLQa3+b1h63A8B
X-Gm-Gg: AZuq6aLurNns5ktFKxTehS8U7UgeAGD+hwgShOWBe+VoNJc/XCq5mOi+uA4VgTDFGrB
	LS2mkvZmPXG+GdlHVeqmNPAVrTkcvueEZCeZesik8XQqr/hEj3wxR1Wl3MVLoEV9rihlLhgF0OE
	gkjU4DK9n0+WDwCQ+s5uKg6NRHAMDxq1Qw4/Rr4dOAxnYKoX1VfjaaVMhbSuB6fVmFBd5OuqLTn
	Wd/grHQcN9ykfSNWNBttCxy5dsNMYrS9ntNwalCWy122RpvmPr4J/76ONKDy/1gOg8P9qUp3KIv
	CGNY0ndjSXZhFaCqYyepsryFCMp3U50A+lpOuLWh2F9R1HQSrzbiEzNtlQBEGGu/7OVMp6cLy3T
	P4x0w36NTzb7oz+NPS5jwhOpGtYAokyqIiqBSx49hVM3iR8bnimHFZIGm+AhcK7/M+CB//pfc8h
	w/CCSF/kXWf1T7p8YhsvhWnxiBBd3DrWCZD3GzAeHDkor2oZtjkRCmv4tqy28AH3dmrsNCKg==
X-Received: by 2002:a05:690c:f84:b0:78c:2fc2:dae3 with SMTP id 00721157ae682-79490d3e62dmr11645117b3.22.1769645805289;
        Wed, 28 Jan 2026 16:16:45 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794828c9e3fsm17767487b3.38.2026.01.28.16.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 16:16:44 -0800 (PST)
Date: Wed, 28 Jan 2026 19:16:44 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 daniel.zahka@gmail.com, 
 willemdebruijn.kernel@gmail.com
Message-ID: <willemdebruijn.kernel.1505ea9f264e2@gmail.com>
In-Reply-To: <20260128210435.161061-1-kuba@kernel.org>
References: <20260128210435.161061-1-kuba@kernel.org>
Subject: Re: [PATCH net] MAINTAINERS: add an entry for PSP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254502-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C521AA31A
X-Rspamd-Action: no action

Jakub Kicinski wrote:
> We are missing a MAINTAINERS entry for PSP, create one.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Willem de Bruijn <willemb@google.com>

