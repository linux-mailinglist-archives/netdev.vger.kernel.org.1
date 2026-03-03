Return-Path: <netdev+bounces-263388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHd2K506p2mofwAAu9opvQ
	(envelope-from <netdev+bounces-263388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:46:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6631F64F3
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F5963015724
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0820826E6FA;
	Tue,  3 Mar 2026 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWYbzIQq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D2351C2C
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567193; cv=pass; b=ABrtnZNbcPRcmUXQlwAGURw6nM6LJZ/BKZ6IeRZ0OshEf2NgiAtqofIOY9fZuXG3kpNlfcqAWIGcletpelX4xywx70wRoTnIQfftNO0oexMF9aX5g8rxMW7sRAV+T6/LAb2f7MMIIaZ4NaP/CAO7BptHs7vDnlwhmbMSEG77PXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567193; c=relaxed/simple;
	bh=KEjCNJ0O7kLNJT3pUq+qobMKTT11UwnTyVP2h22VtcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VikS4rAfyhFC6qPrLzIrm2bO46av8fxGFs8wMmtAdPZii0EaxGXLYgkjkQiwiP1E3ie8weA/BLjhH8MrA5Kiz4p/RVKbUXtubtVPBvJCqaTdmF3ULCxu8oZczIG9q/eH+GAsdfZXvT/2SafYKepXt6hSYfSmGIRldnuDdXSZEBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kWYbzIQq; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2be27fa54feso1094581eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:46:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772567192; cv=none;
        d=google.com; s=arc-20240605;
        b=ML4TDixmZqoA/aznqCm5yTZD1N8C0B4VXWsVlqiOsrWfv5rbeAogF3jGu95X21Dl3I
         sjnrmzdYvmLj9ywysLY6xImCA1kB8veVqHkwISZbscySbgeJJKD+kwXTJIIyWRjOiEKr
         jVIw0KowoW7ovN1/0rlrNsAg4R3suCU6AWQI3FWqxtu+F7A54d0mooUnzNj8Jk6f8tNc
         j/LZzsKGWGV0Y7H3JJFBIfdZLe6TxmVk1wOZw71WTAa2iAG65GqQFkpmR9lrIXCro5b1
         4L8FtQ7JdZzmhKW15lf0O8qZc3V8g5jHZ0Mn/iEyJZWHLqrE4ixriZG/+z9cAhRISWyL
         PIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KEjCNJ0O7kLNJT3pUq+qobMKTT11UwnTyVP2h22VtcI=;
        fh=hs0hOXS6DDobj2vlVdNVBngvwHUaPreh4AQLbLHf8eo=;
        b=A2UcROs6RPq6gHZeyZoHVpPJkghPP3IciHZ0W+iNSj6mU7BdoEdz7WHzn4qhqfpYnZ
         4aM8gqCA7m6OMpAOO/LRF7VxzRgl8sGsJIqbPS8BruQP9P0VXs0Hzyi/PM/lZlNMfLNt
         FusH9s+h/Fob+xhZD4/4iIRsQRMoTaJEPY0q7waJCvjxcSMQ1kYT2UIihqyBbrjOxB4d
         WymzhAvQ8BEnIv2EzggT3a0mMVxS2MNJhRm42qu7ph6nPN5+DS3vLCtOYYYDGlyvFojv
         eu6nXl2i4273dvpf397JXF96XRUzqHY0FueaiKthRnb/MZ9YgVlpfwj1j8DBCuI2PMde
         ifBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567192; x=1773171992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEjCNJ0O7kLNJT3pUq+qobMKTT11UwnTyVP2h22VtcI=;
        b=kWYbzIQqvnXakFd1DzHNnUj9J6UiKbdkbA9F9riLID+5uNezbd5M16uE5n+dXPpNGk
         d64woqjjfQ6qXqJ2CWDlESNtGTkaSkfpV+NzYkC7A7GwhKOAI77SuOEOYlFcAA4a6kkK
         I13dtsMv8UWiFiuDNg67PUNbARj4R8MoFGQADgYxjQ6nl6MkFbR8sNgnvNsL8Jzv12bG
         95E9tnp/bdKVCrtrECEaKlCTH+rsnHq1Vw/V7VnfMdHrII1Sx8Ru8V2O33bCw7HgL2QE
         bIowSEkawNv4zQoVedQsuzaocYDFhpm+Go92rKRDNhJqL8BSNFL+4fGNtYIgAHXV6ipy
         lbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567192; x=1773171992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KEjCNJ0O7kLNJT3pUq+qobMKTT11UwnTyVP2h22VtcI=;
        b=iITpJfOZohD0V/C99QpV/pMl/oZuXLpxqq5TlDoe8TijhXcUPGB0eapmUjpcP6qCwF
         hQ7j5b4z4Q/ta+h1sl6lgJB9Dl2BR2OpZ+AFeBITB5xuoTx+qc7WcqfYU62JNUPj49ei
         keyI/wAtT/LOudmosGu+9C2lRMsx65YblLW9bSxR9BwPg78kTF7OSSz2EZpVhY2Ypg3g
         vOYfGtEyhJLligH5qxT0esy7UlJz+A6lNUI2aHhZbyCzFjUnazj0aFHrv74flqb+HrIH
         TPXc3bZlUs/oqVvagLJnOC/R45TpAYYgLZhUGXWme4pF/H5I33fA+DyR/xb+ST4w+xyN
         wJ/w==
X-Forwarded-Encrypted: i=1; AJvYcCUkr6n7KrVtSINn/bUxSjI+zGSxWJsGzGw+2SRTwOoti2HhW5W88Rc0Mkar1D2KpYwAxYmPsaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNy+TCUrMhzgUqN9+ge1BH8nxjsy74eL6Jr6kouJJM3g/po11U
	W0XFhnUd+9mp/iZ5WqWwYGSCK/tqoo1LpcF+csO6jxBF7urbrfnsOdoTKFvaRgFPUEuTgviy3yZ
	y1F/Pv7N7dkKDBGYd0t2nAh4Yx5EEQ+r6oaMkwNs3
X-Gm-Gg: ATEYQzzPz4zoBkneMqdA1CkPs1igUxQzvDm4AzKXkPP/VtxsDfUtvzzlEj/KdViXpWd
	+yNEQUYN+qzEgsNBgnrsSJ8Njn4oCsMJ8VUvDTnOxLCYIGnsgHqG0fTwFbtAtVVeUouyQHpAX1Y
	7FFObJvIl/okcHScUhh/YlvOD9h4DTr6R1/gkiMD2ggcRZFLJXniXhKFPMEehabFNBxlGNUiWvr
	KHkAHtDebssD+3udrBzog82FutqTRSHasPytAgTrIsUn12HnsNDVd/Ez8bYwlehLjLsA6+KZFE7
	GDSFTak9vyU2yhbWQnWfOD4DF7Vv1mRWG8Ub28ImvDvalkxzJ8ocyXjgk/nAB+8sEd1NBg==
X-Received: by 2002:a05:7022:1287:b0:11b:c1fb:89a with SMTP id
 a92af1059eb24-1278fc1bfedmr7008647c88.32.1772567191230; Tue, 03 Mar 2026
 11:46:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302181432.1836150-1-edumazet@google.com> <20260302181432.1836150-5-edumazet@google.com>
In-Reply-To: <20260302181432.1836150-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Mar 2026 11:46:18 -0800
X-Gm-Features: AaiRm52fttgmOlZd6og98UomkrJuK4vLPy3jIcJGoNpKTk1TzcdIf4coG1gQWME
Message-ID: <CAAVpQUBhh4nc2TSU3-vAcfLNNjRUVv1CVizqifSsO7T5Lz-Wcg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 4/7] net-sysfs: use rps_tag_ptr and remove
 metadata from rps_sock_flow_table
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1C6631F64F3
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
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263388-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 10:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Instead of storing the @mask at the beginning of rps_sock_flow_table,
> use 5 low order bits of the rps_tag_ptr to store the log of the size.
>
> This removes a potential cache line miss to fetch @mask.
>
> More importantly, we can switch to vmalloc_huge() without wasting memory.
>
> Tested with:
>
> numactl --interleave=3Dall bash -c "echo 4194304 >/proc/sys/net/core/rps_=
sock_flow_entries"
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

