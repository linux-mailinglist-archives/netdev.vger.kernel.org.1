Return-Path: <netdev+bounces-266459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MJCCObssGm3ogIAu9opvQ
	(envelope-from <netdev+bounces-266459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:17:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC3925BE7A
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDEF8306467D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC8315853B;
	Wed, 11 Mar 2026 04:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oKVxxnFO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5393818871F
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 04:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202658; cv=pass; b=ZpOEeYLwhEl3DfFtf45wfjIKEOYoQwnAfj40spVc4ZeT6sj1t4+Q/+n1PHT5pK/7WOILESJ2upPL6e4N/zLHKhc+yFQZPcHpm6KhyUI35J1ubJMAyUOn++xbiwXdT1VW2gxFg9vB5baxI5K0FP2FaX3F0y9fIIfWqxgzM6uS/vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202658; c=relaxed/simple;
	bh=B5W5GupRIU7b9LI2m9ae3Ldn1iDON2t1L2MRa+EoXWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtlQzUYJ3SXviD93/CBYI+CUecxVFraEHinp/9CxaC11QF0ORliXKGFZ5UhGyRHQjGppxkEL1g1L0rvLpUvxNI1i9LYIhsOWum318t4aVDze9jnaVT8egAEAVCYh1ZuzTRjEea9n2ikZzMnLduK+ri3YHgrnz1UeIcnBzdWuP88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oKVxxnFO; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-126ea4b77adso16690884c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773202656; cv=none;
        d=google.com; s=arc-20240605;
        b=OfDrQcknV+oXBdLZJM2Dy1LxoEa8RQAQumcNOWp/JmgxmUYgj4bqt7Jf6nlH7fXLvN
         opohRSr4eO5sS0aYWlNZ0lcqs6FX3XRqaw/C+6p4h323rFPv4EnmM0IHwKLZadJ1VT7F
         9R3KtamzdlmL1GOjXnKdOK2MkXdSHgCgzrbWTGm/SbcHRHLU54PISM/IujX0vjLbq9RZ
         RKw9KQljDA5SZIYIzFsBn/E1RK4rSRk2WKARFJdA+kbZlVKwVEdlqUecFqRmTCg/dzW8
         ifQ8zX7qKFXvvEBUkOluaiF+jrGDCh84IGGOIt683Sxnm+VtAOVTcVPGhQgjO1doehme
         3ouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B5W5GupRIU7b9LI2m9ae3Ldn1iDON2t1L2MRa+EoXWs=;
        fh=l8xtgaW4Pbob6a08gGzm/o5LmJVur+y3Dh5o3qEFnio=;
        b=RdERgr7T0kIGluOHAlaRSEUqzHcrjgVYcGHdf6WYzzzIgrhCda2NFS8SflxDXfgVAR
         I7Yv+I0uPMvJMi5LTQ1Z0A78XGsJlazDsAJbg/lAqP8RoEyZrOovVlQEvsIgiuEhbkui
         ZzF+e81SDee0V+aTbCTNqINDft7eMDQ27/MsinegASOn9ZLNFUzYb2Fma+e38ITBFqCB
         mon2TXeXVs0XgdLrhaJTjVazsGcYSAutABDtUep7KJxemBq7Fy/wuD+Nn9YLTLhSK8vZ
         Yll7Rpcl0zdTGMgHdsvfZAIc89tr6E/BGdHoifoQwtBa4GQWYB+1ZJ7rPSif3btkqSbL
         bERg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773202656; x=1773807456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5W5GupRIU7b9LI2m9ae3Ldn1iDON2t1L2MRa+EoXWs=;
        b=oKVxxnFO7vGhaEULIX1dC0Wb/qENyNKup57+3uyR1oMS0PXi8gtNrPq06E1ViZe3q7
         dWqj4cGhtnSGwuLJ4OdVxazK6yiFUY7wAIUzvOyrgZ4ZLymjjOCVIwysJGVw1PkYR8IB
         R4DcyRvv5KkZ2A76/uypUYZB+1P203BKMQbrpiaOOqsq/ro1RRPFqQjyvo6hymwjioLi
         Jxes/aPCoz6mvU3Lzyu35kAQYXpf/EX+PyW5m7qpdrZc00EMG4reE7OxpF9gosCNRLvg
         PK7OMko12ezijef5hx4emIHTOMyk/IpfNY+D0z0i3A6XDboQcI5mT3VTdh2MAQuPutHp
         Hixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773202656; x=1773807456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B5W5GupRIU7b9LI2m9ae3Ldn1iDON2t1L2MRa+EoXWs=;
        b=UDx7NgHbeWWVDFRsQk8BU6JQOYXcU57LINHTqrjmuXnw0BNLy4f8iFItqDsFFAy7vk
         0xwWodKMzFRZLA5KQKEhhpEcIrT2dwTJM+a0GtiMTNwJfX/AVFXLmdEGM40IfqeH9LUD
         vqKCLPzTQNKHzWiKJZF0QG/PiFjumTu6KFH9BgfadiomkDw6eG7d4ZhKvHQEXPt2I75U
         HV9D0GwlTLQwCiQ27ixFm/y4zn8T1+X25rs1S3AR48d5GZjU2GD0oyIpXqYdVZjbGMO3
         qmLwaIsqrwKGVbsb2HYBnNpaAW7gvq3z/Y3jKt9JDm63IvXruBbolJXVl2G8V9Zu8/cM
         3Yqg==
X-Forwarded-Encrypted: i=1; AJvYcCW9puqaVm4YoC2SQM4y/pM7VprkG1WHJUas6o8m9CNapOP6tjawNECURqViXc4HQ5B8V6XPuac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Ay3mgvQYXS4O1qWKg9k/Y28XDQFW9adMVsRV0YMnIlHx05Qj
	yQyjmlx00ZBaLPJztTzqL8GoUaHGUDH7LVx8ee8QkJr/JCoMmHb2bcZjt5sO3ZXtt783s2cf5S4
	SpeFk6aeKezoUoQ+OtWiKE9qc9leATcZLmoe5zGPq
X-Gm-Gg: ATEYQzyNLJT97wPxf+MolgNSCRXICyTQ7BxIINS7yABe6XN9b8uABrTcQUoNaZRoXG8
	RdpDeWm97VlIJMTqhMHLyYwyqDjD2kL+dzjCcAQhR8rOqmEX0BnAMKSfLM30gMqqsjFqYziVlnb
	06wbRLQbLG9H0nlC5srfHFUElKbUvYJ29YvSfxQ9HQPmlTXDEZiSc4tCvlyS3wim1rqFdmMU38X
	acoi7KNw7w9DcfFvlgpmsAvLZD8o+DJJaZzzwTKjuIA1GRmJHHLRE15XuLlsd/Fxy2oQy/YQkT9
	Znzuy1MtXygJLOrtmBFYbVBHfwlQwPoOhhsqCZETNPzkBWLWeoR1cbZE2qWN/aCMEEklD0c=
X-Received: by 2002:a05:7022:78e:b0:119:e56c:18b3 with SMTP id
 a92af1059eb24-128e78494b8mr474830c88.27.1773202655796; Tue, 10 Mar 2026
 21:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310073855.564927-1-edumazet@google.com>
In-Reply-To: <20260310073855.564927-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Mar 2026 21:17:24 -0700
X-Gm-Features: AaiRm53YulYC1U8ap7dcHG_JPcLFVbb7-8zEMv7j0-HQFVJyjS5aEhGRgtrPRYU
Message-ID: <CAAVpQUCagKuX=tPHsHsXUz_fqZWOqboie_a--HqBWKYEo89aYg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: add sysctl_tcp_shrink_window to netns_ipv4_sysctl.rst
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4BC3925BE7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-266459-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:38=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Add missing entry for sysctl_tcp_shrink_window.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

