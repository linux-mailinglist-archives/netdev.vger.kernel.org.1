Return-Path: <netdev+bounces-203278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35831AF11B6
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC953AE1EF
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BC9226CE1;
	Wed,  2 Jul 2025 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fJoebkJR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55718225776
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451752; cv=none; b=INfgf/RDqsEGjPzWz2Xu73cx7blrM3uYjrO348cpQ1IaTh9G5NKERzvrEtl+JLoTn1t/2wMzSCJZVTlDvw/fFrnHbQUOA/bPzQv/xKnuPCy06xWfcLoNBspNziiz+YogNlNNgXwcslAP2rKs6V7sg1QMVmJeMsfYAInlFRFynAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451752; c=relaxed/simple;
	bh=cWow4m0Rwd0/UWRX3Mc8lB827byOAFDFM/yeHEPA4QA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GbtPevRqPoBXv+wdGtIjGc82khibysJY2wgWVj88vJnGMzEOrRVFuTE8nsz0E137ojrhVJoo+Wff757Nsjvp2107/bUyl7X2Q3DPW90DWwKGy480NufQB/7ChdmvE5VOFSyKgXM1IX+reaikZhx1TAloBfoBeNm1f7OE3slU4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fJoebkJR; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ade76b8356cso809511066b.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 03:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751451749; x=1752056549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uDt4izTiA/QJgt4hdK5U7LFObUUS+B2ax53eltImU5E=;
        b=fJoebkJRUg5XUKlke3Qhxg3ObGpSMAUNX72ze8Xn/GadssKa64tr7sMx69kmXZajIh
         Lq1Soch0uxxPQMPmtj9oDmKyMjIbhe5oLt7Vv764QZteY56BQoyrkB147WF0r9P5eMSV
         16bzGjoHDuaFgGkQKXo4sD+xGUoWWw+t5u4lDqkBiB1Tp6a8qjsYdCGVv41NcTJB7YMn
         kdYw153Ree1BdNRtdG2Gj2YiZzRStxkDM7YWHLWkkdlNdAPccg6jUozWBoYLu46t+HMx
         vo6EElekg7TPzb0LUS6nmLxW+wN9O/hrg43EVaM53uomj2mtB3ZvoEALPDUZElTFopQn
         qRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451749; x=1752056549;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDt4izTiA/QJgt4hdK5U7LFObUUS+B2ax53eltImU5E=;
        b=VnyJhGHQBv6U9HXzrBbz5aeSTfYpzQdQxM+MttoQ1g+2Gq06ZhnbPU1s+gfcUl5CkN
         ZjXYIVpUPdYTggOZe7ZMySALWX1EAKSTwlizqnl8Va1WemBTO6wkrQrcipOKO1Mrc6P1
         qQ1pCS4RQSWHY8AIixzLoOSWUvqYneHEZ+Ept0k5m1qZxtu/C7raQxT6mWoa7avE1dw3
         +gEMsKZHrm1sntVkLxZxB94cWr8XcvyHyDtNzGem4ApWd4BjOgdQn+qiiImELKmi2aq8
         n331rfxpU2glldC39p06Gzs2W8I3mEldeVKk3vEEQlwfPXpik52NvCWgENVQ+K/2TGq1
         5Y2A==
X-Gm-Message-State: AOJu0Yz4nzouxHGaWI+DXcfGzqGdUHtg5yVQG2/0dVMPeJWsddmJ6WWJ
	zn5X2Lt+4lmyBXy/dr01BIa9ldCHvPyvoAcJ7s0S1p00/kn8F6I5D0yJHkTdv4uhjBg=
X-Gm-Gg: ASbGncuuiMO1PvGzBqrLJbDUbBZobPSxjzXPJEG32qEupQxCnX5bCmk4Y05Ye2rYvu0
	ZHngSH1A72QSzomYJ1wZsPY60s8fCYHtO8236TNI7HfOIDD8KX3cEFyMsLaTkmQdb0mvw1XhgAW
	xlE1uCvzDHEQiqsm69ZXAmfHxDLN+CE0BGpXvAiVbrti+m/WWJqKcEp0IJoMrNpdpat0VHavYDG
	THasWW580ei9CTOomLJCZbzJUR4EIqcVNAjFymUVx6lR9+xRvok1Usa/kirPpBdTTJ506v6+hMB
	U1f5pTzh/IqcMQF1SEhyzaTowNkuQ3CJsvY/P9YvRWbtQcUMQ0CjGHk=
X-Google-Smtp-Source: AGHT+IGZAfb+F/6xXzskRjMFtI2ozZPN8bXoJ6zk+yB/VWkBTw5kJOkboXQ18iBhxuRgLntTOyKs8Q==
X-Received: by 2002:a17:907:3ccc:b0:ad8:9c97:c2da with SMTP id a640c23a62f3a-ae3c2e196b8mr233153566b.40.1751451748452;
        Wed, 02 Jul 2025 03:22:28 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca200fsm1051566066b.167.2025.07.02.03.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:22:27 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  john.fastabend@gmail.com,
  zijianzhang@bytedance.com,  zhoufeng.zf@bytedance.com
Subject: Re: [Patch bpf-next v4 0/4] tcp_bpf: improve ingress redirection
 performance with message corking
In-Reply-To: <20250701011201.235392-1-xiyou.wangcong@gmail.com> (Cong Wang's
	message of "Mon, 30 Jun 2025 18:11:57 -0700")
References: <20250701011201.235392-1-xiyou.wangcong@gmail.com>
Date: Wed, 02 Jul 2025 12:22:26 +0200
Message-ID: <87v7oanb8d.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 06:11 PM -07, Cong Wang wrote:
> This patchset improves skmsg ingress redirection performance by a)
> sophisticated batching with kworker; b) skmsg allocation caching with
> kmem cache.
>
> As a result, our patches significantly outperforms the vanilla kernel
> in terms of throughput for almost all packet sizes. The percentage
> improvement in throughput ranges from 3.13% to 160.92%, with smaller
> packets showing the highest improvements.
>
> For latency, it induces slightly higher latency across most packet sizes
> compared to the vanilla, which is also expected since this is a natural
> side effect of batching.
>
> Here are the detailed benchmarks:
>
> +-------------+--------+--------+--------+--------+--------+--------+----=
----+--------+--------+--------+--------+
> | Throughput  | 64     | 128    | 256    | 512    | 1k     | 4k     | 16k=
    | 32k    | 64k    | 128k   | 256k   |
> +-------------+--------+--------+--------+--------+--------+--------+----=
----+--------+--------+--------+--------+
> | Vanilla     | 0.17=C2=B10.02 | 0.36=C2=B10.01 | 0.72=C2=B10.02 | 1.37=
=C2=B10.05 | 2.60=C2=B10.12 | 8.24=C2=B10.44 | 22.38=C2=B12.02 | 25.49=C2=
=B11.28 | 43.07=C2=B11.36 | 66.87=C2=B14.14 | 73.70=C2=B17.15 |
> | Patched     | 0.41=C2=B10.01 | 0.82=C2=B10.02 | 1.62=C2=B10.05 | 3.33=
=C2=B10.01 | 6.45=C2=B10.02 | 21.50=C2=B10.08 | 46.22=C2=B10.31 | 50.20=C2=
=B11.12 | 45.39=C2=B11.29 | 68.96=C2=B11.12 | 78.35=C2=B11.49 |
> | Percentage  | 141.18%   | 127.78%   | 125.00%   | 143.07%   | 148.08%  =
 | 160.92%   | 106.52%    | 97.00%     | 5.38%      | 3.13%      | 6.32%   =
   |
> +-------------+--------+--------+--------+--------+--------+--------+----=
----+--------+--------+--------+--------+

That's a bit easier to read when aligned:

| Throughput |    64     |    128    |    256    |    512    |    1k     | =
    4k     |    16k     |    32k     |    64k     |    128k    |    256k   =
 |
|------------+-----------+-----------+-----------+-----------+-----------+-=
-----------+------------+------------+------------+------------+-----------=
-|
|    Vanilla | 0.17=C2=B10.02 | 0.36=C2=B10.01 | 0.72=C2=B10.02 | 1.37=C2=
=B10.05 | 2.60=C2=B10.12 | 8.24=C2=B10.44  | 22.38=C2=B12.02 | 25.49=C2=B11=
.28 | 43.07=C2=B11.36 | 66.87=C2=B14.14 | 73.70=C2=B17.15 |
|    Patched | 0.41=C2=B10.01 | 0.82=C2=B10.02 | 1.62=C2=B10.05 | 3.33=C2=
=B10.01 | 6.45=C2=B10.02 | 21.50=C2=B10.08 | 46.22=C2=B10.31 | 50.20=C2=B11=
.12 | 45.39=C2=B11.29 | 68.96=C2=B11.12 | 78.35=C2=B11.49 |
| Percentage |  141.18%  |  127.78%  |  125.00%  |  143.07%  |  148.08%  | =
 160.92%   |  106.52%   |   97.00%   |   5.38%    |   3.13%    |   6.32%   =
 |

>
> +-------------+-----------+-----------+-----------+-----------+----------=
-+-----------+-----------+-----------+-----------+
> | Latency     | 64        | 128       | 256       | 512       | 1k       =
 | 4k        | 16k       | 32k       | 63k       |
> +-------------+-----------+-----------+-----------+-----------+----------=
-+-----------+-----------+-----------+-----------+
> | Vanilla     | 5.80=C2=B14.02 | 5.83=C2=B13.61 | 5.86=C2=B14.10 | 5.91=
=C2=B14.19 | 5.98=C2=B14.14 | 6.61=C2=B14.47 | 8.60=C2=B12.59 | 10.96=C2=B1=
5.50| 15.02=C2=B16.78|
> | Patched     | 6.18=C2=B13.03 | 6.23=C2=B14.38 | 6.25=C2=B14.44 | 6.13=
=C2=B14.35 | 6.32=C2=B14.23 | 6.94=C2=B14.61 | 8.90=C2=B15.49 | 11.12=C2=B1=
6.10| 14.88=C2=B16.55|
> | Percentage  | 6.55%     | 6.87%     | 6.66%     | 3.72%     | 5.68%    =
 | 4.99%     | 3.49%     | 1.46%     |-0.93%     |
> +-------------+-----------+-----------+-----------+-----------+----------=
-+-----------+-----------+-----------+-----------+

What are throughput and latency units here?

Which microbenchmark was used?

