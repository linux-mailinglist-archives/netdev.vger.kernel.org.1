Return-Path: <netdev+bounces-172214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3BCA50E75
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 23:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E0B3A8525
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809B225D21F;
	Wed,  5 Mar 2025 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2c5paas"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095C3256C63
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213242; cv=none; b=aTzEgo/4NK0ZqcjABS67VcbhlDwHA3aJZv4SI1Nq2yKKRfrnBndt4LC6FgZKH9nU8SpBU0KdFmfetwUWb9HCfiBJiUQMtwASeTBTLGnD1xmX5l6LjV7baZybQ27yYD/57VwLfiBUOO5GMVcrb9zapwr4EVLWfFQLgI94tEKIvo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213242; c=relaxed/simple;
	bh=SwBo80FKLyq+BcCV+n1X7WaLjv9nbUN/6nmJUrvI2h8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZkHRsqqdSRyXKWfPTXZvQtlpwQjdxqa9jgKAD7tR0dhbHvPvJ050Veu7pI60XBgMZjqkqV78nB6cIHnocoW7hZANagIPtEW9v+o7Ogrdisc20/Iimdq9OBwXx8rpQOTGkCOKqffVTISK6bFUUDFbiX3YvOk/z+mX2DXka2miz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2c5paas; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72a145521d6so1870164a34.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 14:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741213240; x=1741818040; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SwBo80FKLyq+BcCV+n1X7WaLjv9nbUN/6nmJUrvI2h8=;
        b=M2c5paastDGVgBMYggRxvaqkoNOOp07g6RGh33V0BBvRRZSIYgu1n6N8Fu2PImZB7i
         /xmsvLjnBB1toaDJ/5a3/48Th8VleCUTqale1y1eEzAECldADnF3G2xIdeH72e1dV9ma
         yOBQLXk10yHrOopN1KZSULnT1E81bhMAuoAw1I8snXNxZHvC2ZqS2ldxVtrDQO4rCsKV
         i5vbI/DQVfQhD9hkPBKFf9ewsh7dgq8rV0H3sYSfbbQ8mAAcPKLN1bqbV4PVfOtaluYY
         Y98PJwvcC+uIEzz682CLbCL8zBfWBJNsXzfGRRZZ78rJaD3t8CjThjjrlI1h0gOlo0nw
         8oWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741213240; x=1741818040;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SwBo80FKLyq+BcCV+n1X7WaLjv9nbUN/6nmJUrvI2h8=;
        b=GUJpQk0+/he1CZ2VQqNpVps/GeJz3E7THbEv6HUiXVBtE8oaNdL3cZDeqJj2cVxecG
         uiKXGJgyfHQmqwSWlGR+vKj44SOiwI7IxCreVKd2hWMK4z4qExSmO/aj/noBSN58M+Yn
         KfYvfNfwDt9zgw9o6deKp3cn+xOjMZ1sPfpH52/NAhtrbld4ggiTfkxodeH5ggaOEkUT
         pLHHawtTYTP9oeXEc8FXHYmX1CrSe13kB1nWgy7vPSg3F7ykBuV9vvs2BvVu05wAuRkk
         DwYEAf7lXolbKiP0DOvvpIE2Q4bcHAjS0N/UGNpDFIGyfmJGyHLCc23niq156IygRC1r
         1j2A==
X-Gm-Message-State: AOJu0YwVK0pW+39ZHtgXVckilrifJqeiv5zdPtVUhmm2ERaNh43+RQyh
	aocg0NMcGgOxVnqXP6PqemreYbWfuF6dkM89h6YcJdd3Xgq7jYgcXEd4LxgO3MStybs/c8aBkJd
	PtOvPQQ+xYTfBuY8TEe3GgvuJ6DAU9A1yWkM=
X-Gm-Gg: ASbGncutZvN2SS+9d+KVpOh7E7focUjDJAkkf/tyqKWBSmOtdiIZfQoWUQw6FzHtXx8
	suvzsVRb3C8k2/eAmNAbe5Nh3q6M001G5SfIIrI32bTrSNw93cxHwjCyIsBWJh0DrhG1g+AG6ew
	ZBtuU/4CXPaQ8lPtnfvqVnfpJ8rUA=
X-Google-Smtp-Source: AGHT+IGdlEWN/VWRck93UjAEYOlLcIJynpMn1yvJyEgxF+yLITMDd5kM5y3LJhMcyuhJfTrfE0TV9tF4h0gZFLpjfPU=
X-Received: by 2002:a05:6830:3709:b0:726:fe71:5371 with SMTP id
 46e09a7af769-72a1faddb32mr2757381a34.6.1741213240005; Wed, 05 Mar 2025
 14:20:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sergey Melnikov <melnikov.sergey.v@gmail.com>
Date: Thu, 6 Mar 2025 01:20:28 +0300
X-Gm-Features: AQ5f1Jp1mI1Q4wZQzLsKBldl9q3XvNL5P8vaVvtIVtTv_cTy7hEXw4Sfr_FVspk
Message-ID: <CAD_cgaze+bbuMsY8BRuYksJEGKWjt2RsJVBhV_psMWxb84Fzaw@mail.gmail.com>
Subject: Heavy tcp_send_ack in recvfrom syscall
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm digging one issue(not sure if it's an issue and not sure how to
fix this) with linux tcp stack. Our application receives a big number
of small packets. Total network utilization isn't really big (dozens
of Mbit/s). Platform: ubuntu 24, ENA-enabled AWS VM.

I observe tcp_send_ack takes half of the whole 'recvfrom' cpu time
(with callstacks to AWS ENA driver). Total recvfrom syscall takes
approx 8.8% and tcp_send_ack is about 5% of the whole profile.

I tried to extend the sockets buffer with proper sysctl's
(net.ipv4.tcp_wmem/net.ipv4.tcp_rmem) and got some improvements.
Nevertheless, I still can't understand how to send ACKs less
frequently and reduce CPU consumption and latency here.

I've found the TCP_QUICKACK socket flag. According to man pages,
disabling this flag will do exactly I need. Will it fix my issue with
manu ACKs?

Is there any ideas or advice on what to do and how to fix such an issue?

--Sergey

