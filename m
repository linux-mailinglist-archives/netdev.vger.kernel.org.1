Return-Path: <netdev+bounces-120498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CEC95998B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E71DAB24D21
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665041BFE0A;
	Wed, 21 Aug 2024 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAw6g5Un"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51511BFE09
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234590; cv=none; b=J3gwqgrEnxUEZy1grvgpaYkz2J91DuRSlK1XXDrKfZnvxLhySZaPJr+keHH52rhgAWV4aJiwWyIImDtaDd2QVpDY7K+BxzXulTLVwYekDr5LZmtv86ixH3BzQo6DUItYaWCxFz3co5tzr8Tgl3zEaWIqLZlcM1QFkH0B7LcaFcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234590; c=relaxed/simple;
	bh=/vKA57Nfqcf6kXaTABlY2wsXHOIFujCoC/kfSLFmm18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrtBss/eWun+FkXCvtpFgyq+YDNWOfXXeHv5a00SEntrUxZZsiDxkxK4QgW7zIz5ANL9wwjoISgLfqOAiVEaHQOGUMW8vriatXVRCwUGf0SqoDHChGaxCWKWjqYfxIrP2+mLeEQwbgnWmiW/QameRU9p8Cxf1wzzJ9KpohAQdBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAw6g5Un; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39d31d16d39so15105385ab.0
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724234588; x=1724839388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1MPWYjSESpQFxlenz/aULLUkBg05FeJ34WveLXDj8I=;
        b=bAw6g5Un6/ecSMF8lEtsNNt2TJtPWDH4i/oCSriImR/397sB0qPJPcBynd7HYAWmCi
         r9+cxczPmqNXwlqexBIGjgw3mjjFwKJfG4Ct8hdwGIgxv1JvLuLWXUhQC6VqOOORmyQB
         ibrRaAOjD7vGm+2Gv6dvlULcqTCTrOEZkUsvKftdSneQY73dlDTgiMN+WEBfXPS3fAx0
         1KRqtWtKTZGqcoFPPYpPXAGHboGTnsKTvRD8jipnhuJMK4lJvJAcjhFoBT+hjKHi/xhZ
         8yXGbt/q4ryzfpd03+Ry7+5pzNZThPWumuZtOgI7aq39RYzJYh8YJcnRn9gYKjH7Hn4j
         PFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724234588; x=1724839388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1MPWYjSESpQFxlenz/aULLUkBg05FeJ34WveLXDj8I=;
        b=LML5QVSYlHYEcSAcu3gabrxO6Z3cee0vhmVufYsHnpe5VlyB+3qtlUQsaz2Q9OAPoT
         3l7u1ekeY8OZRFie/RQA3st5XEX5IxVYekOC0M3NfRH5RlyBfU1j7XnRF+NILmnY4ZoB
         eJgPbZ1xH5Ryg0eQFPakLoNS3av5+2TIEL0egJ9MBwJ1fntaLzDEuEMXJIK3xlO7xGnX
         COFPJjau/2Sr700Qpv2zaMB879o0xZIbnCmEQi0fcTFa4XaJwaUyjsxeNTNg5M4L1tyN
         Pkduh9kwczzIN1kVO5sRZozL8XIcMf+E1poCcvwDK3NwXkLN6PBt5jDk8hPCTSxMI8YC
         aUcw==
X-Forwarded-Encrypted: i=1; AJvYcCU+Hi7E03CllYJ+GtYnMiW3dK53so7YWdaFdPYbRKOPaFTs1OMc4xJiHReFs7zKEv/2gv92vgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWUWRoE9zTdH+PRod5UsjjrOs/KWJEqarQOs0DTrvc8nn5NLDd
	ziDwUnLqeUFNJZzANJ00U5XekeWqHJWbYBml5YDaQxtc3BZ5Ud2ea9ZmmrMlIWJmvGYY3qQW3RY
	nFpIDmPwnvzvLY1M3U4MabUcqldM=
X-Google-Smtp-Source: AGHT+IETwNU3bDhuMhMTszB1nlTP6DhPDF8S9EbQsJK2m+oAGn9rwr4gL5CLfOUV9qz2P+Vhj6IjjW1GOiQ+Kk36ZEY=
X-Received: by 2002:a05:6e02:1a6e:b0:39d:246e:ce8b with SMTP id
 e9e14a558f8ab-39d6c37db61mr19511335ab.8.1724234587781; Wed, 21 Aug 2024
 03:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815113745.6668-1-kerneljasonxing@gmail.com>
 <2ef5d790-5068-41f5-881f-5d2f1e6315e3@redhat.com> <CANn89iLn4=TnBE-0LNvT+ucXDQoUd=Ph+nEoLQOSz0pbdu3upw@mail.gmail.com>
 <CAL+tcoCxGMNrcuDW1VBqSCFtsrvCoAGiX+AjnuNkh8Ukyzfaaw@mail.gmail.com>
In-Reply-To: <CAL+tcoCxGMNrcuDW1VBqSCFtsrvCoAGiX+AjnuNkh8Ukyzfaaw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 21 Aug 2024 18:02:31 +0800
Message-ID: <CAL+tcoAMJ+OwVp6NP4Nb0-ryij4dBC_c9O6ZiDsBWqa+iaHhmw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] tcp: avoid reusing FIN_WAIT2 when trying to
 find port in connect() process
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, kuba@kernel.org, 
	dsahern@kernel.org, ncardwell@google.com, kuniyu@amazon.com, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>, 
	Jade Dong <jadedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Tue, Aug 20, 2024 at 8:54=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hello Eric,
>
> On Tue, Aug 20, 2024 at 8:39=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Tue, Aug 20, 2024 at 1:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On 8/15/24 13:37, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > We found that one close-wait socket was reset by the other side
> > > > which is beyond our expectation,
> > >
> > > I'm unsure if you should instead reconsider your expectation: what if
> > > the client application does:
> > >
> > > shutdown(fd, SHUT_WR)
> > > close(fd); // with unread data
> > >
> >
> > Also, I was hoping someone would mention IPv6 at some point.
>
> Thanks for reminding me. I'll dig into the IPv6 logic.
>
> >
> > Jason, instead of a lengthy ChatGPT-style changelog, I would prefer a
>
> LOL, but sorry, I manually control the length which makes it look
> strange, I'll adjust it.
>
> > packetdrill test exactly showing the issue.
>
> I will try the packetdrill.
>

Sorry that I'm not that good at writing such a case, I failed to add
TS option which will be used in tcp_twsk_unique. So I think I need
more time.

In case that I do not have much time working on this packetdrill, I
decided to copy my simple test code as follows.

The code is very very simple. Please take a look at it :)

Client:
we can use:
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netinet/in.h>

int main(int argc, char *argv[])
{
        unsigned short port =3D 8000;
        char *server_ip =3D "127.0.0.1";

        int sockfd;
        sockfd =3D socket(AF_INET, SOCK_STREAM, 0);
        if(sockfd < 0)
        {
                perror("socket");
                exit(-1);
        }

        struct sockaddr_in server_addr;
        bzero(&server_addr,sizeof(server_addr));
        server_addr.sin_family =3D AF_INET;
        server_addr.sin_port =3D htons(port);
        inet_pton(AF_INET, server_ip, &server_addr.sin_addr);

        int err_log =3D connect(sockfd, (struct sockaddr*)&server_addr,
sizeof(server_addr));
        if(err_log !=3D 0)
        {
                perror("connect");
                close(sockfd);
                exit(-1);
        }

        close(sockfd);

        return 0;
}

or use the following command:
nc -vz 127.0.0.1 8000

Server:
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int main(int argc, char *argv[])
{
        unsigned short port =3D 8000;

        int sockfd =3D socket(AF_INET, SOCK_STREAM, 0);
        if(sockfd < 0)
        {
                perror("socket");
                exit(-1);
        }

        struct sockaddr_in my_addr;
        bzero(&my_addr, sizeof(my_addr));
        my_addr.sin_family =3D AF_INET;
        my_addr.sin_port   =3D htons(port);
        my_addr.sin_addr.s_addr =3D htonl(INADDR_ANY);

        int err_log =3D bind(sockfd, (struct sockaddr*)&my_addr, sizeof(my_=
addr));
        if( err_log !=3D 0)
        {
                perror("binding");
                close(sockfd);
                exit(-1);
        }

        err_log =3D listen(sockfd, 2);
        if(err_log !=3D 0)
        {
                perror("listen");
                close(sockfd);
                exit(-1);
        }

        while(1)
        {

                struct sockaddr_in client_addr;
                char cli_ip[INET_ADDRSTRLEN] =3D "";
                socklen_t cliaddr_len =3D sizeof(client_addr);

                int connfd;
                connfd =3D accept(sockfd, (struct
sockaddr*)&client_addr, &cliaddr_len);
                if(connfd < 0)
                {
                        perror("accept");
                        continue;
                }

                sleep(20); // delay
                close(connfd);
        }
        close(sockfd);
        return 0;
}

They are the basic networking communication code. So this issue can be
easily reproduced by enabling/disabling net.ipv4.tcp_tw_reuse.

As I replied to Paolo last night, maybe I was wrong, but I still
reckon a close-wait socket receives reset skb from a new flow and then
reset, which is incredible.

After applying this patch, if we meet this case, we will find the
kernel behaves like when we switch net.ipv4.tcp_tw_reuse to zero,
notified with "connect: Cannot assign requested address".

I wonder if I understand in the right way?

Thanks,
Jason

