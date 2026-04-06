Return-Path: <netdev+bounces-275783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNf7FBZI1GkRsgcAu9opvQ
	(envelope-from <netdev+bounces-275783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:56:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBE43A857C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D4D3300A269
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 23:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0092239D6CB;
	Mon,  6 Apr 2026 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oo5sy47B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC1938D6BD
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775519760; cv=pass; b=nM1zQl3aq9TXhYRC9u8pKAosk1Wkp4AYQ5XbBjHw/Dnn97h00DZb8ssOlu0fOEMqeUzfpvRbAIhPi3lgrsTbyQpKvX294NbtP3qt4TYOqTkzX1WQKARQr2bDQt4VWEXV3PqY1T0ocs/dOAyswpJbMyB765qznfNeiNCKD9zEkcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775519760; c=relaxed/simple;
	bh=mNC0RxOjT1rujIZKXpezvM303kVKA8rYx4fL/Vqs2EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WW1+4TCct9oJQ+AwLiUb4xrRWMlMSa/XWco1x8WLGpR46nDE6Tvahk3zYmx5BKjkRvBHBXb23Wsv0R0wjYAfUoIlp3Ia5wipAmZ/218OpWEWLSD7vZfPO4BICBiRLIcpV1cMFnG9LgoiB9RPUgBYtgIsqmpzsSxLbx0c2aym8AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oo5sy47B; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-126ea4e9697so27940c88.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 16:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775519759; cv=none;
        d=google.com; s=arc-20240605;
        b=iHYQxktMoJHOqRZpHQCjvWQVPUYvQhGJXRGqu33HI872y80r8KG1F04OFU4/n+JMIt
         v0OGCSqQpeAcCqF4vArMQPAFkXBPOoxNMl/ZdiEbW67QlK1Pi1pRNgX88OFiEbG+5ctY
         PACdcYbw7aYLpNAf9oUF9WN9Z5CfNflXyEArNM7oZ1wQAutzy9fJvUM/JUAHIql8aMwn
         FoSXKSClYrl6nuw3di7obV20ts2pbuFdzwxBCy0rs57DtvohVEPPcAHekRyXcOLY56nx
         cW8ogJmXMl9ruJf8lKl2Q1DT1eVXrAnSzB+b+ZUsaCYhrgo/UAO8v0ilX3YjH4HqbC7i
         PiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mNC0RxOjT1rujIZKXpezvM303kVKA8rYx4fL/Vqs2EE=;
        fh=4Qv7tXfJA5QeQc2w/CIpOfUaHxNL7pUni+9zqpskWQs=;
        b=lD0c3HvnCC1BQV6cXDWbQiLuVC2eOJL82eqhIB2z5Y3c4bOGGFRZuPzZaaahUYNuBm
         jH7Otjk1x69tnbub6ZC9HTd9K8bWXyawSXbjn2t+Kzt43OWG3bB7bPOzRRHvUDCfmmgk
         CpvXUjR+OTlflAJUBLTjV8SvFZ2njaeCIZqbMPhQ7b31F8R4u6sEd//tENc8TPguIh76
         7U571I2Pp3fY/mXe1gG9RLbRFTSOAc2YOd/+ZSs8Q/dkXRNj8PwVyDgXMcGCbly1Q6pj
         mlSAKC8flEKMEHBr5H+Hrrh8RxWvwWsjP5BCNXOoa+t4ZUBmm5YqvZIOdgKH1SjYsaWC
         eS5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775519759; x=1776124559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNC0RxOjT1rujIZKXpezvM303kVKA8rYx4fL/Vqs2EE=;
        b=Oo5sy47BLvycF07fAz4rdmf990675HBV/MNmCPW1Jgsr/QR9aIHJDXxOgNMcAoHX3m
         7No0g3it9qASmaLFekeeRfzunwvkkZWhWtBI7jed0U41a3ciYw7prgw5pIaA39F8HH61
         i1EyZ673uwV+7F57qFHqzF+Twk/sqiJkZt3EGrEwaPzuQraPeYn1Fy0SXIO5qJikstsY
         FjiSW5XV2lySvLJPc5dtH6B0kHm0aVSWOi0njmpU2ov4ILqWwc4/WkrDo/hEf0DV49qD
         TAsaiuNaCgD7BE/k+0bM0yVe4GTN3SwaswKxLE6+xvNxHVU7PiVaoY0gVTLSRYAKQUv8
         PXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775519759; x=1776124559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNC0RxOjT1rujIZKXpezvM303kVKA8rYx4fL/Vqs2EE=;
        b=N1o3sMLBL4nDLnfa44Ax2B9uVGXxey4Ws81xkZFE3a8UPCl4Zbpc6V+xYmCqk2rqjJ
         wv5eI7r8VZe0wsrD46y1B/SDqZJfSxhMpxOZR/INSaWFDv+gl/dL+i3r4CegJ2kUCpxQ
         SlrNaTOYhI3L72y+zt3awvJoOvlfWIWSj3/CbEtY2SV5T+ooicZ6m9e/yHzTQxNzzVSI
         bxdcSpVr0CobITaBSmb4PdnX4Ig8sDG8aXOKU/4+1kvtLoiZTmWZuD/UY2PpLGHNZkVg
         H2H+63EkyTNDQgz3v7ttskkB0eReTEU6hZy5eKS7YxQ76YFCa3xxvD9mE9msxobllLRw
         8IpA==
X-Forwarded-Encrypted: i=1; AJvYcCVdSmUmuvbckQodaaeGxGplD6Ly+NDpil06JDmGuK1P1wrgXn7xYlnMjUkRx7PEuMVaVkwoVpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHRUogqpKY44bpGrkszWZZVxrzT6wKOmZ1mvPXhscAYQA4xg7C
	i9hVbro2h/HUttJeS9ODft+RHvXgkH5McvomOJG5uzwoty78vNzZz3twa1N5mweFHKpjjK30Fbc
	l3/OS2xBbKZl5XWug3+pGIftHVe/E+iskjxPS7OZF
X-Gm-Gg: AeBDieuz8cY/A/TfRhKgHpG9KZJkdP8aAB9EUV86pkhIAwqJvG9ETp0f7lgdKl3fvUM
	VJdILs27Hw0Wghe7Ri7+Zsocjwtvtq2KqrE/IdB3i/DGIoARTPlh84yGE+J2c0GBY0Hm1qx6MCy
	vr+Rv7kC5KdFoD96l0CFsDuRKPlBrQjZCX0WkJxkzVffOo+6+vDr9Ena79e4xnUxW3vOlLRq3Eg
	xRQpZTiR7DlqDYtv/tQBN7pOWChFbJ7oCPfMW72LEXMmApVA+GCYcZSsTAeZWE3u1UnOVnw/pCR
	wyxyt35FkxkObIrH9T8YCT6gdvcRMRVv7mKwvyLs8ECVLeMDzD0=
X-Received: by 2002:a05:7022:125:b0:128:ec96:67 with SMTP id
 a92af1059eb24-12bfc528447mr373932c88.9.1775519758166; Mon, 06 Apr 2026
 16:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404001938.2425670-1-kuba@kernel.org>
In-Reply-To: <20260404001938.2425670-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 6 Apr 2026 16:55:45 -0700
X-Gm-Features: AQROBzDeOf0STIKsuYJfN8E0pCjnkdppvnvskXjFVagVWSQefcDDRfOrT1Nw3ns
Message-ID: <CAHS8izMi+E1AcREKiRUUyAkWn8FMKCoxa+KX+VXLeM_4JvAj_w@mail.gmail.com>
Subject: Re: [PATCH net] net: avoid nul-deref trying to bind mp to incapable device
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275783-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almasrymina@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5BBE43A857C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 5:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Sashiko points out that we use qops in __net_mp_open_rxq()
> but never validate they are null. This was introduced when
> check was moved from netdev_rx_queue_restart().
>
> Look at ops directly instead of the locking config.
> qops imply netdev_need_ops_lock(). We used netdev_need_ops_lock()
> initially to signify that the real_num_rx_queues check below
> is safe without rtnl_lock, but I'm not sure if this is actually
> clear to most people, anyway.
>
> Fixes: da7772a2b4ad ("net: move mp->rx_page_size validation to __net_mp_o=
pen_rxq()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

Honestly better for readability too. I was confused why we check that
we need a lock here but never netdev_lock_ops AFAICT.

FWIW I'm not sure why this branch doesn't have NL_SET_ERR_MSG, but I
didn't look deeply. Probably doesn't matter.

