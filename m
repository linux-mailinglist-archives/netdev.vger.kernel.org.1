Return-Path: <netdev+bounces-288647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMgoJviNCGr4uwMAu9opvQ
	(envelope-from <netdev+bounces-288647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:32:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A8B55C685
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85D47300FF95
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAA73559CA;
	Sat, 16 May 2026 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvDISJU9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7AE274B28
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945523; cv=none; b=VB3aVmK4ZFscmPwelra8+RvpGJNOfIgil3M0w4R/93UX/8Y1thMFgrd+fFKNfC53lP3OCHNz/T7QTb6DDCSGthHmZ51k9rQCm0FQFMIMPhlBk1yg98pQD1yygD8SGqNR/KDOWaeyb4mkqEqbTZIWa+pHX78iQ7H/Tdl5RM5WYaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945523; c=relaxed/simple;
	bh=zp0Wzxf5GjESFC9sIcr1Mv7BfMbalWFXd3pdJEJoAlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKyMXuF3eOicgf3O/kXo+BdkaAgzvwxE2wp61vL9pK3vr5qte07fUtMWh/vFSj8cyH7EsSwl6DpP7BVuRARmTvhImNYA8tQb+MWvR+VqF4n+KjokIO2kqYVcnZQSK1N1cmWSTK9chdknITTg5qobTgFRAAKEtkkx4tFiGkg5++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvDISJU9; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ff5472f263so792602eec.1
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778945521; x=1779550321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66+IfkoE8eHFDfef8jjKBRiRcepTKj7shUMkhMSlsMo=;
        b=fvDISJU93f+rD/01CO8kPSWguvUieqp+dVWA7ZfhI24okHGyHDFMLF5IzueCZbq5np
         /QpJw65bxp2+o9jFC3op7MkAIF87pihmUDsT/cVmkDhlLTuw7PKOG7sHzI8lra4Ce2DD
         Xdt0N5dtxcYi17SaDRfAb5WlY+LICY5CQbNR/pS/5TmRonQMu5h958b3am5LTMTzEpLV
         M4cwh9PX/OmV4OutInH+4Bhcgc1d8Qp5mz8vDlM4+L8eeohXMgd8NQOeLeUb/bfFQ6yO
         mv7/l/gyrlBRhaN0USlVQcOkPfHxXyT0AEGzcWTnD9PRCO04pDC+axSv2MzfeCSBqYLQ
         H/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778945521; x=1779550321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=66+IfkoE8eHFDfef8jjKBRiRcepTKj7shUMkhMSlsMo=;
        b=A9kljVEy0Ttfy15vbwrJElGEfbHBm6IVGJYfaCuyv1mJ/iRCQFXUhFuekXKiHhQZeH
         LVuQSKyGtdEFDOLvB5gJuD0ZBPEp3ahobbqL5gROQhV25c44ksiCpMEq6anhtMfmBTUF
         Q2p/xPnKjju7+EjyMPU4naz5guSq3iqfpR0uwqamO6vP44DNZbJmX/v1tVzuHV8mD7xW
         rS7E/2VNeV+gfz+jxHlXbYsAG0uuu/BVRqNVp3iV+joPJTSVW8v3vt/Q1qlzeLy9/Ma0
         U72JJJKhvTO2a+1DIRwqAjTQn+FwZPhhGxfxWO1HxOyuXaFSRSM8KaFqnKJoYSe7PJM4
         m/mA==
X-Forwarded-Encrypted: i=1; AFNElJ/5PQ+/tAnt+V7QiRAfZ2wDQtcApYHC2fb5uuGfC1sRHesYhficr4NfKAjLTh2bp1cswlhon6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcxS9UCSrZFm2NS3K//IxqAfryLRRilTsqE7TtVQwwnKtyXikn
	+e3wIvb+QE/2ujxRN9hgScT2wUYxGFQZbhdYMmjVW3G1FgXVDJ10ZBkY
X-Gm-Gg: Acq92OEmVx2kdIMHoUVnh3CiN+loJlnynV6D8lLdiPGk769/dJ87fDGI/zl2a6wsHj6
	RTyJpqRTjfNPLFymGUPvr1Yh3kL/ZH8RLIUVIwoZAAoPF8bfPrt2DCPWheHLQVthAVc3oajZI5g
	ofp2EIEDeRm/qksW4n/4EyjmKWaGc9Q4IB+BdQVFj+F98BkxQgoXfptMt9gfPwtOhRYw3vNZ9LR
	hOffpw6eFSjWxkwc4+PCz9S89BziD1bp6p9d+OArbfuPTvFclwrVRlUJygW3Y+9eijPA2gQdn2G
	PETWBmhag2F1sRbrBCagDZ9xc+e2MwBDG48YbWI3ZCUzQgx6PmARLslg+i4XnZ/6HJ2S9AiSBjW
	iz/ZzjYSXXaPJ2pAVms/mKB81VOaP8sU8dEy5EoCzRrPGrShfvL2VTEsufFTjJzQATdVVfC4IG5
	sN7LgWrLp2+tNDBhC5/OnpDb6+SvKrUdG1fdnPsfpDBevc
X-Received: by 2002:a05:7300:d4cf:b0:2ed:e14:42e6 with SMTP id 5a478bee46e88-303986bbe5bmr3670955eec.31.1778945521453;
        Sat, 16 May 2026 08:32:01 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302947e917dsm9708850eec.12.2026.05.16.08.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 08:32:00 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net v4] ipv6: validate extension header length before copying to cmsg
Date: Sat, 16 May 2026 23:31:55 +0800
Message-ID: <20260516153155.2678332-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <willemdebruijn.kernel.1c02e791312d@gmail.com>
References: <20260514035802.1540395-1-tpluszz77@gmail.com> <20260515175522.0aafbfb4@kernel.org> <willemdebruijn.kernel.1c02e791312d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12A8B55C685
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288647-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, 16 May 2026 at 09:41:07 -0400, Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > 	return (len <= skb_tail_pointer(skb) - ptr) ? len : 0;
>
> If making changes, also time to replace the open coded offset
> with sizeof ipv6_opt_hdr and opt_hdr->hdrlen?
> Or perhaps better left for net-next.

Thanks, both make sense.  I'll fold the tail-ptr subtraction
into v5 and post the typed-access refactor against net-next
right after.

Qi

