Return-Path: <netdev+bounces-72201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F930856F2B
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 22:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E77828A569
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07F613DB83;
	Thu, 15 Feb 2024 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="OfGb+fF3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBA9139564
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031864; cv=none; b=AA7tydtOBWZlDY7UuaAjckNqo2u+r0+AusCCo5fUmLOYhKElG3vcWu9bFVEvT5mxI6AOrPRKt9ykF1Uf4A0cB4BU4VOnFg/qhovTcbxvHf6sf0u/CpXhABCYF45tKAGizDQQnSodrwKSjDR2nFC7Sd+/8HOscM80VzwirV7S6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031864; c=relaxed/simple;
	bh=GMdwI3fm9SQE6wKyJ2TCQU/TPq3GZeZGNtA8/BFVjPo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=q4bb3gUyL0nb7lOfF4ufYdL3QMIrN2nuDLauhIMSAJdRTbLX4EMR+5y1npH+K43WnxNN3sFffsD7Ilv++YNBfDv2l1CbBxfOPc2pUN18+67Rv5bhBGU93CClgoxdr/9yk5YHLWmJ+q5TjZPB2xCgC+WkwYp4kjbykEmrE8zNkUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=OfGb+fF3; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4c0afaca1efso689584e0c.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 13:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1708031861; x=1708636661; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FzdAusQEQghjJLnPtEh1TUa7eBlZsPccrUElXKRTBfk=;
        b=OfGb+fF3nG7cSLLIgXMTSEg6Guy8L6Xy9nM/zz8gQBK/Y23j6lVR91l7vRlAu53P5l
         jd8c66U7kIqhpC5dpkW470FOQ6o7O2OnQpgYPBq9D/IkYK60ZnFbwGr1LhpF2hqNv/wM
         Yr9WCgu7Vseh86Eg15/CloIdbUrtYgrC7f271v9dfgjq8pMB8HEnNGqRmPfVr3RKCPHf
         Tc6dYd1P9ZoQ6yM3Z6xw3ZV9xQrzVWSrSdpMIo1BRcB5aQlzv91fNf9jr9gVuN3QdDf+
         0HzifUHo1kEyNNlYsTej5dSIC2ioJCvJYdHad5Fcp2sXrUVH84ZVEuSsVqBzkJXLaZHh
         7nBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708031861; x=1708636661;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FzdAusQEQghjJLnPtEh1TUa7eBlZsPccrUElXKRTBfk=;
        b=e1QlUivINFN3j75qb8CXU9UW98yKWqnATL9ncKNJa7ky3fxSg1o8DwOfPxe3xhIJQJ
         5N1qEdC7zq0rU/4gN98ls7Wl6Esh5/EiI2CBDGSDyqnELffRh6/x02frfAJVcgJtMB+I
         lANn1BcSTkXTcFjUI2hyeGtbe7hy9QdH+lnwCm6UdTdqdpl06HYiOPvDmw2Zhx3j9fP9
         x78A4nm0Lbyl44mLpgjiaWc2vSXKnU3LCIvibK8YbBJJIy2pKM2u7Kgo+rccQa/tDg00
         FhifoSEXh38RGZ3lFou6qjhQmDXeWlub7wCRHaALcGkln2LZzDmYVIcssYShe56CQ99i
         emEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8Oekhwc7YrdkvLK4//QCtCpUfObdVCagXd0vMMXabAQEqDfFyj0ARua47kaOCEr16ARkk+QwjJQkDBOjeiZgx/TjseIuH
X-Gm-Message-State: AOJu0YweuTGEVKjNP+vKtuw1KlepTKs3JyoKl+dBOBziClixjLZxiN0T
	UEcPyJUj3psaGlfARyeaJvayDfrquS93AIM+A79+njNHlPLsfSPW8+ocyyW2+e8YUAqRb5q0Jan
	tateT1Gnl46AqkQIKEhmsipArftqA7sdcDNoKW2zvfqTDjV25T84l
X-Google-Smtp-Source: AGHT+IFPY+wNI0v+lnORgUwKzdEFiKcEI7REdvZ/chmdqRR1E2wIi86IrNOx75FgKlYudm0icpKFDaPBqq8ri4ZtPio=
X-Received: by 2002:a1f:4a04:0:b0:4bd:54d0:e6df with SMTP id
 x4-20020a1f4a04000000b004bd54d0e6dfmr2912410vka.1.1708031861567; Thu, 15 Feb
 2024 13:17:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 15 Feb 2024 13:17:30 -0800
Message-ID: <CALCETrWUtYmSWw9-K1To8UDHe5THqEiwVyeSRNFQBaGuHs4cgg@mail.gmail.com>
Subject: SO_RESERVE_MEM doesn't quite work, at least on UDP
To: Wei Wang <weiwan@google.com>, Network Development <netdev@vger.kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

With SO_RESERVE_MEM, I can reserve memory, and it gets credited to
sk_forward_alloc.  But, as far as I can tell, nothing keeps it from
getting "reclaimed" (i.e. un-credited from sk_forward_alloc and
uncharged).  So, for UDP at least, it basically doesn't work.

Here's a test program in Python:

#!/usr/bin/python3

import typing
import argparse
import socket
import sys
import dataclasses
import struct

SO_RESERVE_MEM = 73

@dataclasses.dataclass
class MemInfo:
    RMEM_ALLOC : int
    RCVBUF : int
    WMEM_ALLOC : int
    SNDBUF : int
    FWD_ALLOC : int
    WMEM_QUEUED : int
    OPTMEM : int
    BACKLOG : int
    DROPS : int

def sk_meminfo(s : socket.socket) -> MemInfo:
    nvars = len(dataclasses.fields(MemInfo))
    buf = s.getsockopt(socket.SOL_SOCKET, 55, 4*nvars) # SO_MEMINFO
    return MemInfo(*struct.unpack(f"{nvars}I", buf))

def main() -> None:
    parser = argparse.ArgumentParser(description='Measure UDP socket
receive buffers')
    parser.add_argument('--sendsize', type=int, default=1024,
                        help='Size of each individual send')
    parser.add_argument('--rcvbuf', type=int,
                        help='SO_RCVBUF')
    parser.add_argument('--reserve-mem', type=int,
                        help='SO_RESERVE_MEM')
    args = parser.parse_args()

    receiver = socket.socket(socket.AF_INET, socket.SOCK_DGRAM,
socket.IPPROTO_UDP)
    receiver.bind(('127.0.0.1', 0))
    bound_addr = receiver.getsockname()
    print('Receiving on %s:%d' % bound_addr, file=sys.stderr)

    sender = socket.socket(socket.AF_INET, socket.SOCK_DGRAM,
socket.IPPROTO_UDP)
    sender.connect(bound_addr)

    if args.rcvbuf is not None:
        receiver.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, args.rcvbuf)
    print('SO_RCVBUF = %d' % receiver.getsockopt(socket.SOL_SOCKET,
socket.SO_RCVBUF))

    if args.reserve_mem is not None:
        receiver.setsockopt(socket.SOL_SOCKET, SO_RESERVE_MEM, args.reserve_mem)
        print('SO_RESERVE_MEM %d succeeded' % args.reserve_mem)

    print(f"{'sent':>10} {'total':>10}")

    meminfo = sk_meminfo(receiver)
    print(f"{'':>10} {0:>10} {meminfo}")

    bytes_sent = 0
    while meminfo.DROPS == 0:
        bytes_now = args.sendsize
        sender.send(bytes_now * b'x')
        bytes_sent += bytes_now

        meminfo = sk_meminfo(receiver)
        print(f"{bytes_now:>10} {bytes_sent:>10} {meminfo}")

    # Be polite to anyone watching using dropwatch or similar tools:
drain the socket
    receiver.setblocking(False)
    ndgrams = 0
    while True:
        try:
            receiver.recv(1)
            ndgrams += 1
        except OSError:
            break
    print('Drained %d datagrams' % ndgrams)

    meminfo = sk_meminfo(receiver)
    print(f"{'':>10} {'':>10} {meminfo}")


if __name__ == '__main__':
    main()

SO_RCVBUF = 212992
SO_RESERVE_MEM 100000 succeeded
      sent      total
                    0 MemInfo(RMEM_ALLOC=0, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=102400, WMEM_QUEUED=0,
OPTMEM=0, BACKLOG=0, DROPS=0)
      1024       1024 MemInfo(RMEM_ALLOC=2304, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=100096, WMEM_QUEUED=0,
OPTMEM=0, BACKLOG=0, DROPS=0)
      1024       2048 MemInfo(RMEM_ALLOC=4608, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=97792, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)
      1024       3072 MemInfo(RMEM_ALLOC=6912, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=95488, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)
      1024       4096 MemInfo(RMEM_ALLOC=9216, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=93184, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)
      1024       5120 MemInfo(RMEM_ALLOC=11520, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=90880, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)
      1024       6144 MemInfo(RMEM_ALLOC=13824, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=88576, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)
      1024       7168 MemInfo(RMEM_ALLOC=16128, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=86272, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)
      1024       8192 MemInfo(RMEM_ALLOC=18432, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=83968, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)
      1024       9216 MemInfo(RMEM_ALLOC=20736, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=81664, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)
      1024      10240 MemInfo(RMEM_ALLOC=23040, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=79360, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)
      1024      11264 MemInfo(RMEM_ALLOC=25344, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=77056, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)
      1024      12288 MemInfo(RMEM_ALLOC=27648, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=74752, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)
      1024      13312 MemInfo(RMEM_ALLOC=29952, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=72448, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)
      1024      14336 MemInfo(RMEM_ALLOC=32256, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=70144, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)

<-- Okay, looks like it's working as expected.

      1024      94208 MemInfo(RMEM_ALLOC=211968, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=1024, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)
      1024      95232 MemInfo(RMEM_ALLOC=214272, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=2816, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=0)

<-- And now we're out of space.

      1024      96256 MemInfo(RMEM_ALLOC=214272, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=2816, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=1)

<-- And we drop the next datagram, as expected

Drained 93 datagrams
                      MemInfo(RMEM_ALLOC=0, RCVBUF=212992,
WMEM_ALLOC=0, SNDBUF=212992, FWD_ALLOC=4096, WMEM_QUEUED=0, OPTMEM=0,
BACKLOG=0, DROPS=1)

<-- Now read all the queued data.  Whoops, sk_forward_alloc == 4096.
Where'd the reservation go?

Am I right that this is a bug?  What's the right way to fix it?

--Andy

