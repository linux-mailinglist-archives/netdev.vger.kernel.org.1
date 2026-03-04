Return-Path: <netdev+bounces-263539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEKFEQeQp2lKiQAAu9opvQ
	(envelope-from <netdev+bounces-263539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:51:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8331F9AF5
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9AD1A3033E2B
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8862A328B61;
	Wed,  4 Mar 2026 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATb+PIEk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8093264ED
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589043; cv=none; b=MTzKTApfdXj9teIITLaxbMnHzQP2ajAqW0mc/Pp/IqY3Rw+l3H0IJgYK1QEfC3K6k74bEMgbvIh+qHu5OivEuiSqPmt8kfVldQxJzq0I7Jddp7wbd5i5JhMZFwzKX/Q5L76hH7l+EkRDt9EVQE3waT4yxnBCHY1bIuI0etur1oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589043; c=relaxed/simple;
	bh=DNMnKVuHdO1FUjTvVYtWFdXMdVN6pCAalo8PuzYepJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LdxfHohi/Tsxoyos6wIg6ZttupVCl1qm89JuSwSk4v0qXjgZIPhrXvI96DCOlTxDm0EO8ZLZLLC7SLP2U3c5XEpGuq8f78sqEKOAk1w42lkJsOIAUOFy+GvsGLFtQnDyIbRRqAD++wo5rXh/8yrVRB0LePJ65SQnBaTGLljM4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATb+PIEk; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so5574448a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 17:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772589042; x=1773193842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNMnKVuHdO1FUjTvVYtWFdXMdVN6pCAalo8PuzYepJw=;
        b=ATb+PIEk4SyFlfYFxpRGimNr88PSj+A5kWXfnysNg9UspIUtQP/U7lUwdu7C3opzAj
         AWcsaVovzIUFtbYJrJP+4BkcCyY64A/888CgKw9yYFMQtomEXH0j3Z/RGrzo5SnHg0wv
         2Lmucs51Nnmjz3+f9vwDart+PedHiEZ0uwHCQn+/rcYy5fJTjr0oSFT1dsztWNoYpZbn
         SIfdC7vl91lwioRfsgnFhMhY/MtXvFIII017pc2Mo9ftYKeTSQQ2bFqScm+i6qMt2Tu6
         fGQZvAWFJ4wEw5dI/jg9igMD06QsYjLpR8OPaSv8a/Fl+xksWqhy/H+Z0+TYasiuGBQf
         Bong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772589042; x=1773193842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DNMnKVuHdO1FUjTvVYtWFdXMdVN6pCAalo8PuzYepJw=;
        b=vp1/fqOAyS+9gfeE7BErUSg9ZZQNTKnZGHDC9QNLf+XAOmqL4yCI5bPUjsbdOvWP0v
         cD5YNtP3yJ+5l0Cy02YsDjxg7MpC8ni8p/8VMGblmdNzjiCstBO3RRQTOnnamJGWxoxj
         ah+6D3TWDtVvxouLQVVjyy9L83vMruCXdpneotxKi/y2D5JxWZYON0LCXyaDhkWXljk0
         8Ze+vizdbIEGNJ/3wcM+KGF1910+TsxNGtPuk2f6vDQrVFQ+cGph2XPG0YXrkbvV3MRw
         3lfmDRigPT/k0cVXxkGlsjC4S7ttqm54LFdhoU/ajY3H5IRwp1voo7b5wk2M6DvbPuex
         ZhEw==
X-Forwarded-Encrypted: i=1; AJvYcCUsOuhl9nDkq4BGFHAL6ziVdVHUt5Ue3wYnW3PjqqlY2SIDgs+37QJ9ecZWjXTpmoAzrOaMxPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypfa96z/BHle4pLqb9AnA7RghMGGw2pZ1B3J5cdid8tse7cch5
	Tew3KiX5qx5fk26pSW0mGJGHaEJczxwevyRQOlpA6l1VlKVL1FDx61yk
X-Gm-Gg: ATEYQzyCFVPASztApR1Fx5KxZ8pL9peVWye8vKheXXFEdd66XzN8uasATrISdzjpkUb
	/bCUVZ4D23+e3BSlSVX+j4nhXa3RWGdDuctTs09sKmlzxFh4oReEOFbnIj8kRffBCqSZ/RMsjI+
	PkrHL8OphxONLUJtqRZDmaJSfhVTOj085sTD7SdQmZYCjZwp2FOGJD4J1j7VUnDkzLcAMziXJX6
	roXxS4RaxOaTCp7UP6OfIpj8D2umDZVqxb/I6e1nCPTk5vmlC/Q581QsMg+g9cuZkB5tXU+qsNr
	Z2pSgdXD8JKJhHI+iuTgw1KtX7U2trSmK0l0HCcm1aj6v31+CpF6GPveCUdDCOqLZ0bj/4HVwbU
	hKv11H75BoyzA7rdQi+Q9HjduoH8F1LTGhL4fxHgFuyn/SQlJgku/YCvXuLpEevAbxcxhqwwXq1
	vYR/dXwz51SjJgVDLlGPgSBhe6Ky5lzyuCsR3Z53v/JjfD+c2xsGNlwXNqNw6H4NxE+isY/ylhY
	HJOF9YdOxj6MSkQ4zIP5oc=
X-Received: by 2002:a17:90b:394b:b0:354:9c20:83e4 with SMTP id 98e67ed59e1d1-359a69c14a8mr389684a91.2.1772589041794;
        Tue, 03 Mar 2026 17:50:41 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599bf8aba4sm3574006a91.0.2026.03.03.17.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:50:41 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: edumazet@google.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	horms@kernel.org,
	kmta1236@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2] tcp: shrink per-packet memset in __tcp_transmit_skb()
Date: Wed,  4 Mar 2026 10:50:32 +0900
Message-Id: <20260304015032.751148-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89i+xwmBA-QiYwd_UR2_XK0aXZGZi8+uvBugQ2-MnmZvpaA@mail.gmail.com>
References: <CANn89i+xwmBA-QiYwd_UR2_XK0aXZGZi8+uvBugQ2-MnmZvpaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B8331F9AF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,gmail.com,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-263539-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmta1236@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

> Please read Documentation/process/maintainer-netdev.rst (about the ~24
> hours delay)
>
> Also, please CC MPTCP maintainers, since this patch could impact MPTCP.

Oops, thank you for the pointer. I will follow the 24+ hours delay if I need to update the patch.
I will also CC MPTCP maintainers later.

