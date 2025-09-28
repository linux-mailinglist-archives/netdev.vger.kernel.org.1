Return-Path: <netdev+bounces-227031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB3BA7483
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 18:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F5137ACA20
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 16:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF40221265;
	Sun, 28 Sep 2025 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8FeKHBO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40331DB125
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759075531; cv=none; b=b+h8/paAKkDh4Jv8FGUrKX0V7xdTw9cXuTl1V3shKmUrojnKW7STJHaVTrfsqroP7cAksCJW5169BouXI2ptUTZOC6CKMo2jh0mi7tJ6mTIOkFp5c+y80/ko3hTBBIEQLLgwtzilcellBMW0b7rOprlAvkdx1HMgaZmBEGFhZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759075531; c=relaxed/simple;
	bh=xS06CZsnsZAJDKSLkTR21prF5nIWjZCeOQH1o5JWwas=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ezmSg+6JQ99VdYY2wJ4Yd89vSxoqlBhHP9mVu8Tx7tfKQLbKM3pyLsroPExIAgRck70WvPqrxHl369qaOk7eMjCnoah95v2GkX5gS2haJA+Yy5MNO60/aHF5yvvyW5Xq3/6pBWZVykYPw+Hy53SqdNhDf+d4eF3JYuxtYl52hg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8FeKHBO; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-854fcb187b2so425769785a.2
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759075528; x=1759680328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wi0WOb7K8cgYoD8A2f30ICNA+mX/xckLI9C8AsvRACA=;
        b=T8FeKHBOcLIzTAbF6Q5j0ambtD6L5ws999f+864wdlFIpmQE8A5NRlAi0xY1RJ6d0x
         muJrcpQpkmJRlPEl8KYo9cnrv6LOvc02xsnbZwaXlN2EqoYM0KGfacPk44flhTl4QCTL
         +TaD4zKwQR/8zKQVlsA4rEI/5nNGmWI45NfDP7DXD+IYyB/zWiFaGfeQi+TELDa8dS56
         8BkZszO5b9Y3SQHB395HQXksV+cfonQ094Sv/pvEg5LMnFlnt7vHNNpE3mlDmaEEinab
         W1j15pZDY5IuwUpUswLtwJhoV2+okz3wCE1F6q6WGFh0UH0j/yFkhc+cr1VdP5CgVoN8
         z3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759075528; x=1759680328;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wi0WOb7K8cgYoD8A2f30ICNA+mX/xckLI9C8AsvRACA=;
        b=E4nXKIueBSOx1avHTQlUZkcCsipzU2c3avISDmapiijXdM8BJlbsueO4gEYuJzMLnz
         gaeRVyH6Dd9g/foG7OYcAJ2aiSSE7F8q/U7AQ4AFyZRcsAEzOFtD/Zixq0BKPKOBK0RH
         n0HGixyat4Y4gcEAhTg/Hb/9vdgNWydU0rtR2PVJjdajVAturf4Kl5ZuW5Uyt7GQx8Qu
         7u2uKo03tJVfVdMc3ugkLn79Vpi5Xoo1NOfSMyifo4+xRgk/MvnlcTb30CTaCmb/jNGn
         6Mypr0NoU7Eah4wCV9mKpMBJ6zvjQEsC73XmnygnqteiQ0RqSfl78t0LC6GsjXRwL2Ih
         tJNw==
X-Gm-Message-State: AOJu0Yy6Dt5rWqAZQy7HX+XXnX36UCB/DtzT90DQOapZEPVNHqhzEmTk
	kS3+82R2G2CxGnzt6jl/q97TBwnSoG2Kn+Vss4T1HLDxut2XZi0ja+jE
X-Gm-Gg: ASbGnctLZ5kde57zBnUFXPwVA0VrvWBeULq2/dGB3ktcxcECxpYXxY8jFW+jjfShNIn
	L31dsdEq7WutJCSj62tciihXbFr/XL1zOuWz7UCtBO8yII3yB/EaTPebA0hKcL/OoUgGK5fNita
	TfmlHGbmPnF5miBnKmJ7rQYxgEfc3TkkKEhZa7Y6JNVhQrPWkcB/mD+Gtiu4esqqNUvvyGOqz7k
	bmurbtVhHnAkbOXLnLqLy2OXQn8kjeRODw6iMQlGWEdM9+p+sUfbPDvNYlyMnE6PyBSPQMOmEVM
	49caLvZ31hb/riwVQ3k7yK6aGD/Kvewdg7PzIDgH2uXm7K7ziBVmqjMJnXrMQbTsJ6jwqP3IxAz
	m2iHtY9bFEXyDkxzbw1Tz7iaIoH6/lqI/07lM/SwAfaAj8wJLGZejufvAi1/hhxqVAZ2IZw==
X-Google-Smtp-Source: AGHT+IHUovQ4Q2dXcqO+KESXmWgxf5N64nFFYIxU9/DeAzDETJDgR9D5qrN4wDfDoJVVFjiLYYwpfg==
X-Received: by 2002:a05:620a:2686:b0:848:ce89:b8f6 with SMTP id af79cd13be357-85aea320d9bmr1555227885a.74.1759075528453;
        Sun, 28 Sep 2025 09:05:28 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-85c306b641asm603534585a.37.2025.09.28.09.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 09:05:27 -0700 (PDT)
Date: Sun, 28 Sep 2025 12:05:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 petrm@nvidia.com, 
 willemb@google.com, 
 shuah@kernel.org, 
 daniel.zahka@gmail.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.b88097f659ab@gmail.com>
In-Reply-To: <20250927225420.1443468-4-kuba@kernel.org>
References: <20250927225420.1443468-1-kuba@kernel.org>
 <20250927225420.1443468-4-kuba@kernel.org>
Subject: Re: [PATCH net-next v3 3/8] selftests: drv-net: add PSP responder
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> PSP tests need the remote system to support PSP, and some PSP capable
> application to exchange data with. Create a simple PSP responder app
> which we can build and deploy to the remote host. The tests themselves
> can be written in Python but for ease of deploying the responder is in C
> (using C YNL).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>  tools/testing/selftests/drivers/net/Makefile  |   9 +
>  .../selftests/drivers/net/psp_responder.c     | 483 ++++++++++++++++++
>  .../testing/selftests/drivers/net/.gitignore  |   1 +
>  3 files changed, 493 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/net/psp_responder.c
> 
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 102cfb36846c..bd3af9a34e2f 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -27,4 +27,13 @@ TEST_PROGS := \
>  	xdp.py \
>  # end of TEST_PROGS
>  
> +# YNL files, must be before "include ..lib.mk"
> +YNL_GEN_FILES := psp_responder
> +TEST_GEN_FILES += $(YNL_GEN_FILES)
> +
>  include ../../lib.mk
> +
> +# YNL build
> +YNL_GENS := psp
> +
> +include ../../net/ynl.mk
> diff --git a/tools/testing/selftests/drivers/net/psp_responder.c b/tools/testing/selftests/drivers/net/psp_responder.c
> new file mode 100644
> index 000000000000..f309e0d73cbf
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/psp_responder.c
> @@ -0,0 +1,483 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/poll.h>
> +#include <sys/socket.h>
> +#include <sys/time.h>
> +#include <netinet/in.h>
> +#include <unistd.h>
> +
> +#include <ynl.h>
> +
> +#include "psp-user.h"
> +
> +#define dbg(msg...)				\
> +do {						\
> +	if (opts->verbose)			\
> +		fprintf(stderr, "DEBUG: " msg);	\
> +} while (0)
> +
> +static bool should_quit;
> +
> +struct opts {
> +	int port;
> +	int devid;
> +	bool verbose;
> +};
> +
> +enum accept_cfg {
> +	ACCEPT_CFG_NONE = 0,
> +	ACCEPT_CFG_CLEAR,
> +	ACCEPT_CFG_PSP,
> +};
> +
> +static struct {
> +	unsigned char tx;
> +	unsigned char rx;
> +} psp_vers;
> +
> +static int conn_setup_psp(struct ynl_sock *ys, struct opts *opts, int data_sock)
> +{
> +	struct psp_rx_assoc_rsp *rsp;
> +	struct psp_rx_assoc_req *req;
> +	struct psp_tx_assoc_rsp *tsp;
> +	struct psp_tx_assoc_req *teq;
> +	char info[300];

Optionally a clearer upper bound, e.g., based on PSP_MAX_KEY.
And a struct, to avoid having to cast to beyond the SPI field.

> +	int key_len;
> +	ssize_t sz;
> +	__u32 spi;
> +
> +	dbg("create PSP connection\n");
> +
> +	// Rx assoc alloc
> +	req = psp_rx_assoc_req_alloc();
> +
> +	psp_rx_assoc_req_set_sock_fd(req, data_sock);
> +	psp_rx_assoc_req_set_version(req, psp_vers.rx);
> +
> +	rsp = psp_rx_assoc(ys, req);
> +	psp_rx_assoc_req_free(req);
> +
> +	if (!rsp) {
> +		perror("ERROR: failed to Rx assoc");
> +		return -1;
> +	}
> +
> +	// SPI exchange
> +	key_len = rsp->rx_key._len.key;
> +	memcpy(info, &rsp->rx_key.spi, sizeof(spi));
> +	memcpy(&info[sizeof(spi)], rsp->rx_key.key, key_len);
> +	sz = sizeof(spi) + key_len;
> +
> +	send(data_sock, info, sz, MSG_WAITALL);

Return value not checked

> +	psp_rx_assoc_rsp_free(rsp);
> +
> +	sz = recv(data_sock, info, sz, MSG_WAITALL);
> +	if (sz < 0) {
> +		perror("ERROR: failed to read PSP key from sock");
> +		return -1;
> +	}
> +	memcpy(&spi, info, sizeof(spi));
> +
> +	// Setup Tx assoc
> +	teq = psp_tx_assoc_req_alloc();
> +
> +	psp_tx_assoc_req_set_sock_fd(teq, data_sock);
> +	psp_tx_assoc_req_set_version(teq, psp_vers.tx);
> +	psp_tx_assoc_req_set_tx_key_spi(teq, spi);
> +	psp_tx_assoc_req_set_tx_key_key(teq, &info[sizeof(spi)], key_len);
> +
> +	tsp = psp_tx_assoc(ys, teq);
> +	psp_tx_assoc_req_free(teq);
> +	if (!tsp) {
> +		perror("ERROR: failed to Tx assoc");
> +		return -1;
> +	}
> +	psp_tx_assoc_rsp_free(tsp);
> +
> +	return 0;
> +}
> +
> +static void send_ack(int sock)
> +{
> +	send(sock, "ack", 4, MSG_WAITALL);
> +}
> +
> +static void send_err(int sock)
> +{
> +	send(sock, "err", 4, MSG_WAITALL);
> +}
> +
> +static void send_str(int sock, int value)
> +{
> +	char buf[128];
> +	int ret;
> +
> +	ret = snprintf(buf, sizeof(buf), "%d", value);
> +	send(sock, buf, ret + 1, MSG_WAITALL);
> +}
> +
> +static void
> +run_session(struct ynl_sock *ys, struct opts *opts,
> +	    int server_sock, int comm_sock)
> +{
> +	enum accept_cfg accept_cfg = ACCEPT_CFG_NONE;
> +	struct pollfd pfds[3];
> +	size_t data_read = 0;
> +	int data_sock = -1;
> +
> +	while (true) {
> +		bool race_close = false;
> +		int nfds;
> +
> +		memset(pfds, 0, sizeof(pfds));
> +
> +		pfds[0].fd = server_sock;
> +		pfds[0].events = POLLIN;
> +
> +		pfds[1].fd = comm_sock;
> +		pfds[1].events = POLLIN;
> +
> +		nfds = 2;
> +		if (data_sock >= 0) {
> +			pfds[2].fd = data_sock;
> +			pfds[2].events = POLLIN;
> +			nfds++;
> +		}
> +
> +		dbg(" ...\n");
> +		if (poll(pfds, nfds, -1) < 0) {
> +			perror("poll");
> +			break;
> +		}
> +
> +		/* data sock */
> +		if (pfds[2].revents & POLLIN) {
> +			char buf[8192];
> +			ssize_t n;
> +
> +			n = recv(data_sock, buf, sizeof(buf), 0);
> +			if (n <= 0) {
> +				if (n < 0)
> +					perror("data read");
> +				close(data_sock);
> +				data_sock = -1;
> +				dbg("data sock closed\n");
> +			} else {
> +				data_read += n;
> +				dbg("data read %zd\n", data_read);
> +			}
> +		}
> +
> +		/* comm sock */
> +		if (pfds[1].revents & POLLIN) {
> +			static char buf[4096];
> +			static ssize_t off;
> +			bool consumed;
> +			ssize_t n;
> +
> +			n = recv(comm_sock, &buf[off], sizeof(buf) - off, 0);
> +			if (n <= 0) {
> +				if (n < 0)
> +					perror("comm read");
> +				return;
> +			}
> +
> +			off += n;
> +			n = off;
> +
> +#define __consume(sz)						\
> +		({						\
> +			if (n == (sz)) {			\
> +				off = 0;			\
> +			} else {				\
> +				off -= (sz);			\
> +				memmove(buf, &buf[(sz)], off);	\
> +			}					\
> +		})
> +
> +#define cmd(_name)							\
> +		({							\
> +			ssize_t sz = sizeof(_name);			\
> +			bool match = n >= sz &&	!memcmp(buf, _name, sz); \
> +									\
> +			if (match) {					\
> +				dbg("command: " _name "\n");		\
> +				__consume(sz);				\
> +			}						\
> +			consumed |= match;				\
> +			match;						\
> +		})
> +
> +			do {
> +				consumed = false;
> +
> +				if (cmd("read len"))
> +					send_str(comm_sock, data_read);
> +
> +				if (cmd("data echo")) {
> +					if (data_sock >= 0)
> +						send(data_sock, "echo", 5,
> +						     MSG_WAITALL);
> +					else
> +						fprintf(stderr, "WARN: echo but no data sock\n");
> +					send_ack(comm_sock);
> +				}
> +				if (cmd("data close")) {
> +					if (data_sock >= 0) {
> +						close(data_sock);
> +						data_sock = -1;
> +						send_ack(comm_sock);
> +					} else {
> +						race_close = true;
> +					}
> +				}
> +				if (cmd("conn psp")) {
> +					if (accept_cfg != ACCEPT_CFG_NONE)
> +						fprintf(stderr, "WARN: old conn config still set!\n");
> +					accept_cfg = ACCEPT_CFG_PSP;
> +					send_ack(comm_sock);
> +					/* next two bytes are versions */
> +					if (off >= 2) {
> +						memcpy(&psp_vers, buf, 2);
> +						__consume(2);
> +					} else {
> +						fprintf(stderr, "WARN: short conn psp command!\n");
> +					}
> +				}
> +				if (cmd("conn clr")) {
> +					if (accept_cfg != ACCEPT_CFG_NONE)
> +						fprintf(stderr, "WARN: old conn config still set!\n");
> +					accept_cfg = ACCEPT_CFG_CLEAR;
> +					send_ack(comm_sock);
> +				}
> +				if (cmd("exit"))
> +					should_quit = true;
> +#undef cmd
> +
> +				if (!consumed) {
> +					fprintf(stderr, "WARN: unknown cmd: [%zd] %s\n",
> +						off, buf);
> +				}
> +			} while (consumed && off);
> +		}
> +
> +		/* server sock */
> +		if (pfds[0].revents & POLLIN) {
> +			if (data_sock >= 0) {
> +				fprintf(stderr, "WARN: new data sock but old one still here\n");
> +				close(data_sock);
> +				data_sock = -1;
> +			}
> +			data_sock = accept(server_sock, NULL, NULL);
> +			if (data_sock < 0) {
> +				perror("accept");
> +				continue;
> +			}
> +			data_read = 0;
> +
> +			if (accept_cfg == ACCEPT_CFG_CLEAR) {
> +				dbg("new data sock: clear\n");
> +				/* nothing to do */
> +			} else if (accept_cfg == ACCEPT_CFG_PSP) {
> +				dbg("new data sock: psp\n");
> +				conn_setup_psp(ys, opts, data_sock);
> +			} else {
> +				fprintf(stderr, "WARN: new data sock but no config\n");
> +			}
> +			accept_cfg = ACCEPT_CFG_NONE;
> +		}
> +
> +		if (race_close) {
> +			if (data_sock >= 0) {
> +				/* indeed, ordering problem, handle the close */
> +				close(data_sock);
> +				data_sock = -1;
> +				send_ack(comm_sock);
> +			} else {
> +				fprintf(stderr, "WARN: close but no data sock\n");
> +				send_err(comm_sock);
> +			}
> +		}
> +	}
> +	dbg("session ending\n");
> +}
> +
> +static int spawn_server(struct opts *opts)
> +{
> +	struct sockaddr_in6 addr;
> +	int fd;
> +
> +	fd = socket(AF_INET6, SOCK_STREAM, 0);
> +	if (fd < 0) {
> +		perror("can't open socket");
> +		return -1;
> +	}
> +
> +	memset(&addr, 0, sizeof(addr));
> +
> +	addr.sin6_family = AF_INET6;
> +	addr.sin6_addr = in6addr_any;
> +	addr.sin6_port = htons(opts->port);
> +
> +	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr))) {
> +		perror("can't bind socket");
> +		return -1;
> +	}
> +
> +	if (listen(fd, 5)) {
> +		perror("can't listen");
> +		return -1;
> +	}
> +
> +	return fd;
> +}
> +
> +static int run_responder(struct ynl_sock *ys, struct opts *opts)
> +{
> +	int server_sock, comm;
> +
> +	server_sock = spawn_server(opts);
> +	if (server_sock < 0)
> +		return 4;
> +
> +	while (!should_quit) {
> +		comm = accept(server_sock, NULL, NULL);
> +		if (comm < 0) {
> +			perror("accept failed");
> +		} else {
> +			run_session(ys, opts, server_sock, comm);
> +			close(comm);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void usage(const char *name, const char *miss)
> +{
> +	if (miss)
> +		fprintf(stderr, "Missing argument: %s\n", miss);
> +
> +	fprintf(stderr, "Usage: %s -p port [-v] [-d psp-dev-id]\n", name);
> +	exit(EXIT_FAILURE);
> +}
> +
> +static void parse_cmd_opts(int argc, char **argv, struct opts *opts)
> +{
> +	int opt;
> +
> +	while ((opt = getopt(argc, argv, "vp:d:")) != -1) {
> +		switch (opt) {
> +		case 'v':
> +			opts->verbose = 1;
> +			break;
> +		case 'p':
> +			opts->port = atoi(optarg);
> +			break;
> +		case 'd':
> +			opts->devid = atoi(optarg);
> +			break;
> +		default:
> +			usage(argv[0], NULL);
> +		}
> +	}
> +}
> +
> +static int psp_dev_set_ena(struct ynl_sock *ys, __u32 dev_id, __u32 versions)
> +{
> +	struct psp_dev_set_req *sreq;
> +	struct psp_dev_set_rsp *srsp;
> +
> +	fprintf(stderr, "Set PSP enable on device %d to 0x%x\n",
> +		dev_id, versions);
> +
> +	sreq = psp_dev_set_req_alloc();
> +
> +	psp_dev_set_req_set_id(sreq, dev_id);
> +	psp_dev_set_req_set_psp_versions_ena(sreq, versions);
> +
> +	srsp = psp_dev_set(ys, sreq);
> +	psp_dev_set_req_free(sreq);
> +	if (!srsp)
> +		return 10;

typo, return 1 intended? (does not matter functionally, of course)

> +
> +	psp_dev_set_rsp_free(srsp);
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct psp_dev_get_list *dev_list;
> +	bool devid_found = false;
> +	__u32 ver_ena, ver_cap;
> +	struct opts opts = {};
> +	struct ynl_error yerr;
> +	struct ynl_sock *ys;
> +	int first_id = 0;
> +	int ret;
> +
> +	parse_cmd_opts(argc, argv, &opts);
> +	if (!opts.port)
> +		usage(argv[0], "port"); // exits
> +
> +	ys = ynl_sock_create(&ynl_psp_family, &yerr);
> +	if (!ys) {
> +		fprintf(stderr, "YNL: %s\n", yerr.msg);
> +		return 1;
> +	}
> +
> +	dev_list = psp_dev_get_dump(ys);
> +	if (ynl_dump_empty(dev_list)) {
> +		if (ys->err.code)
> +			goto err_close;
> +		fprintf(stderr, "No PSP devices\n");
> +		goto err_close_silent;
> +	}
> +
> +	ynl_dump_foreach(dev_list, d) {
> +		if (opts.devid) {
> +			devid_found = true;
> +			ver_ena = d->psp_versions_ena;
> +			ver_cap = d->psp_versions_cap;
> +		} else if (!first_id) {
> +			first_id = d->id;
> +			ver_ena = d->psp_versions_ena;
> +			ver_cap = d->psp_versions_cap;
> +		} else {
> +			fprintf(stderr, "Multiple PSP devices found\n");
> +			goto err_close_silent;
> +		}
> +	}
> +	psp_dev_get_list_free(dev_list);
> +
> +	if (opts.devid && !devid_found) {
> +		fprintf(stderr, "PSP device %d requested on cmdline, not found\n",
> +			opts.devid);
> +		goto err_close_silent;
> +	} else if (!opts.devid) {
> +		opts.devid = first_id;
> +	}
> +
> +	if (ver_ena != ver_cap) {
> +		ret = psp_dev_set_ena(ys, opts.devid, ver_cap);
> +		if (ret)
> +			goto err_close;
> +	}
> +
> +	ret = run_responder(ys, &opts);
> +
> +	if (ver_ena != ver_cap && psp_dev_set_ena(ys, opts.devid, ver_ena))
> +		fprintf(stderr, "WARN: failed to set the PSP versions back\n");
> +
> +	ynl_sock_destroy(ys);
> +
> +	return ret;
> +
> +err_close:
> +	fprintf(stderr, "YNL: %s\n", ys->err.msg);
> +err_close_silent:
> +	ynl_sock_destroy(ys);
> +	return 2;
> +}
> diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
> index d634d8395d90..585ecb4d5dc4 100644
> --- a/tools/testing/selftests/drivers/net/.gitignore
> +++ b/tools/testing/selftests/drivers/net/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  napi_id_helper
> +psp_responder
> -- 
> 2.51.0
> 



