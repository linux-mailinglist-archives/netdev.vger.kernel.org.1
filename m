Return-Path: <netdev+bounces-238774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF6CC5F4F5
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB10A35B720
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3702FB0AF;
	Fri, 14 Nov 2025 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wm56XKBS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7822F2616
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154240; cv=none; b=b+icFw2kJCWVGfPBwhNtFbkEiUpcrbUJEaySMEiLbX1+ZEszI7bI3HjSr7gHODKbLSWIwygyWd6Vw/q7+w1x67Ih2WbV9Xk0ApQFaBy+X7bq9lSE+KnD0pfYDTAk6Xgh6Rjd7gHQ/BWsD1g3LWoBIg4vlWMt9etSw7O4uOCEFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154240; c=relaxed/simple;
	bh=ZRcRJ1ov7fpVFeO0n+4bpYll87M1TfvtzdHhTADiZa0=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=pznxet4Z/SXmI+PkgISNL4RCH2IgRjh+p86ZnCpX677DK/2rQjJQdeLFFo9w+fuV8aDxHyLz0DW8w0qSeSNovpVnaM81HYItJFPufqVeOYDR0VecmeF94d1oy9aF3E/xW8puV/stotRznKgelELHG980Wef1v1H3OF7NAY3Kjog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wm56XKBS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29800ac4ef3so5145405ad.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763154238; x=1763759038; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSwPNBVKqHvFOHifXAQL/wy5G/S/bOyQ5Syqnj/jJ+Y=;
        b=Wm56XKBStq/gahFwmQ6IvmqYm8X+HZxXANoXGvmA3INNSH2Z28lZnAHbi7jOQEvN5I
         ofdpCeALSnYAUUGcOzl3vFTPz9kXx5Cq2YiSWBR9ttSD1PtIwt55BEyW51+Zyn6GBU/W
         QyCXyYYPF00WCLjeBLsAfz8LHpIG89RPtbJjJbWp+4nu43bkgwSth9d7MQl1zytuaHZt
         N0/z3LCS9M4dKTdzYW+0Ov4yrv9tNmxkqrlLSMnBC7n7No9UbwLXVDTgLBg2kzbOMycK
         bTBm0xvysCboXuTd4GOJNxeJEf/yOcXTz4FIseFhKE7sKJJgRvnnKD28MxNLIOwt510N
         ydbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763154238; x=1763759038;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSwPNBVKqHvFOHifXAQL/wy5G/S/bOyQ5Syqnj/jJ+Y=;
        b=hrLMNsFNxWMs4l7ylYWBl2EjHpQWzCgkV1lmy50kZWuSg8nAshzHp2Np+6vV5t8IDZ
         CFf+kFmi/t6nUjDxjqIzopKvNhQQWBfEIh37xybig9DPlbmyOAICUyj+AYbcKPilCfeU
         qz/c/A9JiUdIYI/CHOyEa3ZCPSZhKPxF3A6GBSX8W2gPP88YVA2oH7u24lDs71L8kyGi
         oF3r1AjfQmCBHPcBSfNkdvmugiiSQAKb2Zk/IBglZeHR0VqjkStxP+5KYmLQg/dJ9O8u
         gYst3e0BJdMMtjtjwv6d06rFYD8pU3uM6+wqlk3PSTjT+/jYyosC+1On9DY4+tjyPSps
         oKCA==
X-Gm-Message-State: AOJu0YzVf0bnXSn63P+WC0tVG2NnfqgGtpP5BvApzNHo5/xr4V6KS+sz
	ugo5meDmK0ldES3yERKsUuZZ4uErl6/IgRV3lQtixhTDTiMJ35wm1YK+d+5U/z/10Qk=
X-Gm-Gg: ASbGncuY1BjVOHMAgv13WFWdHpOAfZtguvI4qEmOG6nZtwA0HVePbqCeB3Qh5gOlZlb
	AUBWp8uaa8Ic9a7ktQvsL7zSqkqWvxBUoQzAq/l+qYsefWUZ0JmoVqoX38VubfbiYWNaubGYeBB
	pNcHMDTXRAS0hOfX345x2oaWRd8m/SofW6CyeqgBxiIE8JWs0gsnO0as22FHXI7EkMondf+WTec
	vNloU8+Y6mtwJn7ucvuG0WlLbJUYaKXoY2EANU4YMkFwdlSenqEAQX+2DnDSINf0/oYCri955KN
	1NLkJ8Zw19wUcMTqEL1kqICuB+cKpiC+kxmU7TKt/5Wj8zVhdTyxDIPB3cDptmGZ94D/mHqMEYw
	g2I1Ivv2/wO8DIKd4GTaWWgLYwqCBG3nHSUOlGpiZr0tFe7u+9RQA4tCQUjqkcPLsBVZnxwxnII
	3gU2vfLmLUO0Ek2tz6ysgdrh1hEXtNb9OHFQRteb2ludju5vZzpcD+ntBlkHPKuo8yc1rJ
X-Google-Smtp-Source: AGHT+IHztQdPvLUyB10HsZiaR7voGOSu4JHarm5WjnOUBYfsbSMcJqjB+POF4uLco63r+mmdPevblA==
X-Received: by 2002:a17:902:f683:b0:266:914a:2e7a with SMTP id d9443c01a7336-2986a73babdmr28028165ad.6.1763154237611;
        Fri, 14 Nov 2025 13:03:57 -0800 (PST)
Received: from smtpclient.apple (043224233218.static.ctinets.com. [43.224.233.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0c35sm64542715ad.52.2025.11.14.13.03.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2025 13:03:57 -0800 (PST)
From: Miao Wang <shankerwangmiao@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: [Question] Unexpected SO_PEEK_OFF behavior
Message-Id: <3B969F90-F51F-4B9D-AB1A-994D9A54D460@gmail.com>
Date: Sat, 15 Nov 2025 05:03:44 +0800
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81)

Hi, all

I learned from the Kernel documents that SO_PEEK_OFF manages an offset =
for a
socket. When using recv(MSG_PEEK), the returning data should start from =
the
offset. As stated in the manual, suppose the incoming data for a socket =
is
aaaabbbb, and the initial SO_PEEK_OFF is 0. Two calls of recv(fd, buf, =
4,=20
MSG_PEEK) will return aaaa and bbbb respectively. However, I noticed =
that when=20
the incoming data is supplied in two batches, the second recv() will =
return in=20
total all the 8 bytes, instead of 4. As shown below:

Receiver                     Sender
--------                     ------
                             send(fd, "aaaabbbb", 8)
recv(fd, buf, 4, MSG_PEEK)
Get "aaaa" in buf
recv(fd, buf, 100, MSG_PEEK)
Get "bbbb" in buf
------------------------------------------------
recv(fd, buf, 4, MSG_PEEK)
                             send(fd, "aaaa", 4)
Get "aaaa" in buf
recv(fd, buf, 100, MSG_PEEK)
                             send(fd, "bbbb", 4)
Get "aaaabbbb" in buf


I also notice that this only happens to the unix socket. I wonder if it =
is the
expected behavior? If so, how can one tell that if the returned data =
from
recv(MSG_PEEK) contains data before SO_PEEK_OFF?

The code used to carry out the test is modified from sk_so_peek_off.c =
from the
Kernel test suite.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/wait.h>

static void sk_peek_offset_set(int s, int offset)
{
        if (setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, =
sizeof(offset)))
                perror("Failed to set SO_PEEK_OFF value");
}

static int sk_peek_offset_get(int s)
{
        int offset =3D -0xbeef;
        socklen_t len =3D sizeof(offset);

        if (getsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, &len))
                perror("Failed to get SO_PEEK_OFF value");
        return offset;
}

void test(int af, int type, int proto, int do_sleep){
        int s[2] =3D {0, 0};
        int r =3D 0;
        int offset;
        pid_t sender =3D -1;
        char buf[100];
        if (af =3D=3D AF_UNIX){
                r =3D socketpair(af, type, proto, s);
                if (r < 0) {
                        perror("Temporary socket creation failed");
                        return;
                }
        } else {
                r =3D socket(af, type, proto);
                if (r < 0) {
                        perror("Temporary socket creation failed");
                        return;
                }
                s[0] =3D r;
                r =3D socket(af, type, proto);
                if (r < 0) {
                        perror("Temporary socket creation failed");
                        close(s[0]);
                        return;
                }
                s[1] =3D r;
                union {
                        struct sockaddr sa;
                        struct sockaddr_in a4;
                        struct sockaddr_in6 a6;
                } addr;
                memset(&addr, 0, sizeof(addr));
                addr.sa.sa_family =3D af;
                r =3D bind(s[0], &addr.sa, sizeof(addr));
                if (r < 0) {
                        perror("Socket bind failed");
                        goto out;
                }
                r =3D getsockname(s[0], &addr.sa, =
&(socklen_t){sizeof(addr)});
                if (r < 0) {
                        perror("getsockname() failed");
                        goto out;
                }
                if (proto =3D=3D IPPROTO_TCP) {
                        r =3D listen(s[0], 1);
                        if (r < 0) {
                                perror("Socket listen failed");
                                goto out;
                        }
                }
                r =3D connect(s[1], &addr.sa, sizeof(addr));
                if (r < 0) {
                        perror("Socket connect failed");
                        goto out;
                }
                if (proto =3D=3D IPPROTO_TCP) {
                        r =3D accept(s[0], NULL, NULL);
                        if (r < 0) {
                                perror("Socket accept failed");
                                goto out;
                        }
                        close(s[0]);
                        s[0] =3D r;
                }
        }
        offset =3D sk_peek_offset_get(s[1]);
        if (offset =3D=3D -0xbeef) {
                printf("SO_PEEK_OFF not supported");
                goto out;
        }
        printf("Initial offset: %d\n", offset);
        sk_peek_offset_set(s[1], 0);
        offset =3D sk_peek_offset_get(s[1]);
        printf("Offset after set to 0: %d\n", offset);
        sender =3D fork();
        if (sender =3D=3D 0) {
                /* Transfer a message */
                if (do_sleep){
                        if (send(s[0], (char *)("aaaa"), 4, 0) < 0) {
                                perror("Temporary probe socket send() =
failed");
                                abort();
                        }
                        sleep(2);
                        if (send(s[0], (char *)("bbbb"), 4, 0) < 0) {
                                perror("Temporary probe socket send() =
failed");
                                abort();
                        }
                } else {
                        if (send(s[0], (char *)("aaaabbbb"), 8, 0) < 0) =
{
                                perror("Temporary probe socket send() =
failed");
                                abort();
                        }
                }
                exit(0);
        }
        int len =3D recv(s[1], buf, 4, MSG_PEEK);
        if (len < 0) {
                perror("recv() failed");
                goto out;
        }
        printf("Read %d bytes: %.*s\n", len, (int)len, buf);
        offset =3D sk_peek_offset_get(s[1]);
        printf("Offset after reading first 4 bytes: %d\n", offset);
        len =3D recv(s[1], buf, 100, MSG_PEEK);
        if (len < 0) {
                perror("recv() failed");
                goto out;
        }
        printf("Read %d bytes: %.*s\n", len, (int)len, buf);
        offset =3D sk_peek_offset_get(s[1]);
        printf("Offset after reading all bytes: %d\n", offset);
        len =3D recv(s[1], buf, 100, 0);
        if (len < 0) {
                perror("recv() failed");
                goto out;
        }
        printf("Flushed %d bytes: %.*s\n", len, (int)len, buf);
        offset =3D sk_peek_offset_get(s[1]);
        printf("Offset after flushing all bytes: %d\n", offset);
out:
        close(s[0]);
        close(s[1]);
        if(sender > 0) {
                int st;
                waitpid(sender, &st, 0);
        }
}

int main(void) {
        printf("=3D=3D=3D Test SO_PEEK_OFF with AF_UNIX, SOCK_STREAM, No =
sleep =3D=3D=3D\n");
        test(AF_UNIX, SOCK_STREAM, 0, 0);
        printf("=3D=3D=3D Test SO_PEEK_OFF with AF_UNIX, SOCK_STREAM, =
Sleep =3D=3D=3D\n");
        test(AF_UNIX, SOCK_STREAM, 0, 1);
        printf("=3D=3D=3D Test SO_PEEK_OFF with AF_INET, SOCK_STREAM, =
IPPROTO_TCP, No sleep =3D=3D=3D\n");
        test(AF_INET, SOCK_STREAM, IPPROTO_TCP, 0);
        printf("=3D=3D=3D Test SO_PEEK_OFF with AF_INET, SOCK_STREAM, =
IPPROTO_TCP, Sleep =3D=3D=3D\n");
        test(AF_INET, SOCK_STREAM, IPPROTO_TCP, 1);
        printf("=3D=3D=3D Test SO_PEEK_OFF with AF_INET6, SOCK_STREAM, =
IPPROTO_TCP, No sleep =3D=3D=3D\n");
        test(AF_INET6, SOCK_STREAM, IPPROTO_TCP, 0);
        printf("=3D=3D=3D Test SO_PEEK_OFF with AF_INET6, SOCK_STREAM, =
IPPROTO_TCP, Sleep =3D=3D=3D\n");
        test(AF_INET6, SOCK_STREAM, IPPROTO_TCP, 1);
        return 0;
}

My execution result on 6.12.48 kernel (Debian 6.12.48+deb13-amd64) is:

=3D=3D=3D Test SO_PEEK_OFF with AF_UNIX, SOCK_STREAM, No sleep =3D=3D=3D
Initial offset: -1
Offset after set to 0: 0
Read 4 bytes: aaaa
Offset after reading first 4 bytes: 4
Read 4 bytes: bbbb
Offset after reading all bytes: 8
Flushed 8 bytes: aaaabbbb
Offset after flushing all bytes: 0
=3D=3D=3D Test SO_PEEK_OFF with AF_UNIX, SOCK_STREAM, Sleep =3D=3D=3D
Initial offset: -1
Offset after set to 0: 0
Read 4 bytes: aaaa
Offset after reading first 4 bytes: 4
Read 8 bytes: aaaabbbb
Offset after reading all bytes: 12
Flushed 8 bytes: aaaabbbb
Offset after flushing all bytes: 4
=3D=3D=3D Test SO_PEEK_OFF with AF_INET, SOCK_STREAM, IPPROTO_TCP, No =
sleep =3D=3D=3D
Initial offset: -1
Offset after set to 0: 0
Read 4 bytes: aaaa
Offset after reading first 4 bytes: 4
Read 4 bytes: bbbb
Offset after reading all bytes: 8
Flushed 8 bytes: aaaabbbb
Offset after flushing all bytes: 0
=3D=3D=3D Test SO_PEEK_OFF with AF_INET, SOCK_STREAM, IPPROTO_TCP, Sleep =
=3D=3D=3D
Initial offset: -1
Offset after set to 0: 0
Read 4 bytes: aaaa
Offset after reading first 4 bytes: 4
Read 4 bytes: bbbb
Offset after reading all bytes: 8
Flushed 8 bytes: aaaabbbb
Offset after flushing all bytes: 0
=3D=3D=3D Test SO_PEEK_OFF with AF_INET6, SOCK_STREAM, IPPROTO_TCP, No =
sleep =3D=3D=3D
Initial offset: -1
Offset after set to 0: 0
Read 4 bytes: aaaa
Offset after reading first 4 bytes: 4
Read 4 bytes: bbbb
Offset after reading all bytes: 8
Flushed 8 bytes: aaaabbbb
Offset after flushing all bytes: 0
=3D=3D=3D Test SO_PEEK_OFF with AF_INET6, SOCK_STREAM, IPPROTO_TCP, =
Sleep =3D=3D=3D
Initial offset: -1
Offset after set to 0: 0
Read 4 bytes: aaaa
Offset after reading first 4 bytes: 4
Read 4 bytes: bbbb
Offset after reading all bytes: 8
Flushed 8 bytes: aaaabbbb
Offset after flushing all bytes: 0


Cheers,
Miao Wang=

