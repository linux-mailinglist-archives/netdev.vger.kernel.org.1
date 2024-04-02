Return-Path: <netdev+bounces-84186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC735895EFC
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 23:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A431C20C90
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A034B15E218;
	Tue,  2 Apr 2024 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="PGCyGbYn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F38379DD4
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 21:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094966; cv=none; b=Mv+DyH3OgBaQGX/yzS3lLdXshQkAZRSWhsOc5fhBmT6wFylY7i0oQbThAFR7kzozf37R131eLzxaWsIz7Ssz7BzorT9UbhfDphc88r6bDmJqpd2CdWqjAO9V/ToG3wBQMDGMKlOLq8SitDalAEVofOnKBGtnBtb9bVfsMrGsdg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094966; c=relaxed/simple;
	bh=o0/tgYOPVK4RUccak/ArNBhu36UYkFASS131a7IdTWw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eTQ6DwyiAry0cN+MqtrpOP4WWkSZnda4jJcyHkzK5iubNzWC/0VuMQTtkTG5V0T31mwDxolB9LTPSozGydh6aLQWsTRJsBavRKswFLj5TncHEs/fVCgfBNEzF2eGMKmyoIHWoS8CDs9+zcJPG5v1lzAbJhQAEdxbptJas1PTvgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=PGCyGbYn; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29f69710cbbso253905a91.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 14:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1712094962; x=1712699762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JXtgF46wAFERKzPziTatMZZxQSCwcqss9TAJxMpwKtM=;
        b=PGCyGbYnSB96AnT9+E+1LrI7MA//B3xidkEiL2BN3Krnp87Sd9J8CRaNE7e/eaiCNY
         uCQsXE4iUdFePShuSRSDaSJpZspNmOHg9XRdkHjlDBJjBZMC1PvRFNa3wZySohDRtpCO
         HmhmnD2DRAZc8422dpqx0daUZd9J7o5SPGAT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712094962; x=1712699762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXtgF46wAFERKzPziTatMZZxQSCwcqss9TAJxMpwKtM=;
        b=NHWWg/NJnFj60VXfXxkpSVypw564IxOj6bYN9/JtwLI4bqdAE4j3eXTq8Jsay4LhxG
         AQ7jeGB4ZhhTeDQMzZR9vmJuCfSNmogmP/QQoThAfex0e8K0/ARMOdq1k9g777OIX9uw
         wNjXy1xI0Q+VSN6b5DCD1F036R0eLjud8IhGaLO4w4n9xy96qKadrJd/+awWK1RBuWpV
         M0Z03m0jcdzKDix8TsRAS+LBS2LIP7YlvzeeFV3PRGLAD3u53snyCssi0SpcKxFPZr/H
         G6NYEn/86BBSYjl1bjrqFTGavU0D7pUHfVbARUGFph5vNVgpcE/rzBLGDsB7BWlEtJeq
         KMew==
X-Gm-Message-State: AOJu0Yxm549TY+MqG8zRAyP/RhMWtMEeojmCuE5miqsZS1zyfMRomz/g
	f1NZG4EIH1tQjWMxnIHeBjvF84tEZ9ela/zTjQts6c46mQqNHFfaHaU/AT8kWqE=
X-Google-Smtp-Source: AGHT+IG5g+leMRosLdVtVBaSTDH/faGIi9lpMVKUcpGJbK/HK5HOBxJs9nTfta2yACuwSsFHo3r2dw==
X-Received: by 2002:a17:90a:cf8b:b0:2a2:94f9:34cf with SMTP id i11-20020a17090acf8b00b002a294f934cfmr252197pju.0.1712094962173;
        Tue, 02 Apr 2024 14:56:02 -0700 (PDT)
Received: from localhost ([192.173.69.11])
        by smtp.gmail.com with UTF8SMTPSA id n91-20020a17090a2ce400b0029bf32b524esm13389012pjd.13.2024.04.02.14.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 14:56:01 -0700 (PDT)
From: Hechao Li <hli@netflix.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Soheil Hassas Yeganeh <soheil@google.com>
Cc: netdev@vger.kernel.org,
	kernel-developers@netflix.com,
	Hechao Li <hli@netflix.com>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH net-next] tcp: update window_clamp together with scaling_ratio
Date: Tue,  2 Apr 2024 14:54:06 -0700
Message-Id: <20240402215405.432863-1-hli@netflix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"),
we noticed an application-level timeout due to reduced throughput. This
can be reproduced by the following minimal client and server program.

server:

int main(int argc, char *argv[]) {
    int sockfd;
    char buffer[256];
    struct sockaddr_in srv_addr;

    // Create socket
    sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if (sockfd < 0) {
       perror("server: socket()");
       return -1;
    }
    bzero((char *) &srv_addr, sizeof(srv_addr));
    srv_addr.sin_family = AF_INET;
    srv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
    srv_addr.sin_port = htons(8080);
    // Bind socket
    if (bind(sockfd, (struct sockaddr *) &srv_addr,
	     sizeof(srv_addr)) < 0)  {
        perror("server: bind()");
        close(sockfd);
        return -1;
    }
    // Listen for connections
    listen(sockfd,5);

    while(1) {
        int filefd = -1, newsockfd = -1;
        struct sockaddr_in cli_addr;
        socklen_t cli_len = sizeof(cli_addr);

        // Accept connection
        newsockfd = accept(sockfd, (struct sockaddr *)&cli_addr, &cli_len);
        if (newsockfd < 0) {
            perror("server: accept()");
            goto end;
        }
        // Read filename from client
        bzero(buffer, sizeof(buffer));
        ssize_t n = read(newsockfd,buffer,sizeof(buffer)-1);
        if (n < 0) {
            perror("server: read()");
            goto end;
        }
        // Open file
        filefd = open(buffer, O_RDONLY);
        if (filefd < 0) {
            perror("server: read()");
            goto end;
        }
        // Get file size
        struct stat file_stat;
        if(fstat(filefd, &file_stat) < 0) {
            perror("server: fstat()");
            goto end;
        }
        // Send file
        off_t offset = 0;
        ssize_t bytes_sent = 0, bytes_left = file_stat.st_size;
        while ((bytes_sent = sendfile(newsockfd, filefd,
				      &offset, bytes_left)) > 0) {
            bytes_left -= bytes_sent;
        }

end:
        // Close file and client socket
        if (filefd > 0) {
                close(filefd);
        }
        if (newsockfd > 0) {
                close(newsockfd);
        }
    }
    close(sockfd);
    return 0;
}

client:

int main(int argc, char *argv[]) {
    int sockfd, filefd;
    char *server_addr = argv[1];
    char *filename = argv[2];
    struct sockaddr_in sockaddr;
    char buffer[256];
    ssize_t n;

    if ((sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) == -1) {
        perror("client: socket()");
        return -1;
    }

    sockaddr.sin_family = AF_INET;
    inet_pton(AF_INET, server_addr, &sockaddr.sin_addr);
    sockaddr.sin_port = htons(8080);

    int val = 65536;
    if (setsockopt(sockfd, SOL_SOCKET, SO_RCVBUF,
		   &val, sizeof(val)) < 0) {
        perror("client: setockopt(SO_RCVBUF)");
        return -1;
    }
    if (connect(sockfd, (struct sockaddr*)&sockaddr,
		sizeof(sockaddr)) == -1) {
        close(sockfd);
        perror("client: connect()");
        return -1;
    }

    // Send filename to server
    n = write(sockfd, filename, strlen(filename));
    if (n < 0) {
         perror("client: write()");
         return -1;
    }
    // Open file
    filefd = open(filename, O_WRONLY | O_CREAT, 0666);
    if(filefd < 0) {
         perror("client: open()");
         return -1;
    }
    // Read file from server
    while((n = read(sockfd, buffer, sizeof(buffer))) > 0) {
        write(filefd, buffer, n);
    }
    // Close file and socket
    close(filefd);
    close(sockfd);
    return 0;
}

Before the commit, it takes around 22 seconds to transfer 10M data.
After the commit, it takes 40 seconds. Because our application has a
30-second timeout, this regression broke the application.

The reason that it takes longer to transfer data is that
tp->scaling_ratio is initialized to a value that results in ~0.25 of
rcvbuf. In our case, SO_RCVBUF is set to 65536 by the application, which
translates to 2 * 65536 = 131,072 bytes in rcvbuf and hence a ~28k
initial receive window.

Later, even though the scaling_ratio is updated to a more accurate
skb->len/skb->truesize, which is ~0.66 in our environment, the window
stays at ~0.25 * rcvbuf. This is because tp->window_clamp does not
change together with the tp->scaling_ratio update. As a result, the
window size is capped at the initial window_clamp, which is also ~0.25 *
rcvbuf, and never grows bigger.

This patch updates window_clamp along with scaling_ratio. It changes the
calculation of the initial rcv_wscale as well to make sure the scale
factor is also not capped by the initial window_clamp.

A comment from Tycho Andersen <tycho@tycho.pizza> is "What happens if
someone has done setsockopt(sk, TCP_WINDOW_CLAMP) explicitly; will this
and the above not violate userspace's desire to clamp the window size?".
This comment is not addressed in this patch because the existing code
also updates window_clamp at several places without checking if
TCP_WINDOW_CLAMP is set by user space. Adding this check now may break
certain user space assumption (similar to how the original patch broke
the assumption of buffer overhead being 50%). For example, if a user
space program sets TCP_WINDOW_CLAMP but the applicaiton behavior relies
on window_clamp adjusted by the kernel as of today.

Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
Signed-off-by: Hechao Li <hli@netflix.com>
Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
---
 net/ipv4/tcp_input.c  | 6 +++++-
 net/ipv4/tcp_output.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5d874817a78d..a0cfa2b910d5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -237,9 +237,13 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 		 */
 		if (unlikely(len != icsk->icsk_ack.rcv_mss)) {
 			u64 val = (u64)skb->len << TCP_RMEM_TO_WIN_SCALE;
+			struct tcp_sock *tp = tcp_sk(sk);
 
 			do_div(val, skb->truesize);
-			tcp_sk(sk)->scaling_ratio = val ? val : 1;
+			tp->scaling_ratio = val ? val : 1;
+
+			/* Make the window_clamp follow along. */
+			tp->window_clamp = tcp_full_space(sk);
 		}
 		icsk->icsk_ack.rcv_mss = min_t(unsigned int, len,
 					       tcp_sk(sk)->advmss);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e3167ad96567..2341e3f9db58 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -239,7 +239,7 @@ void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 		/* Set window scaling on max possible window */
 		space = max_t(u32, space, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
 		space = max_t(u32, space, READ_ONCE(sysctl_rmem_max));
-		space = min_t(u32, space, *window_clamp);
+		space = min_t(u32, space, sk->sk_rcvbuf);
 		*rcv_wscale = clamp_t(int, ilog2(space) - 15,
 				      0, TCP_MAX_WSCALE);
 	}
-- 
2.34.1


