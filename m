Return-Path: <netdev+bounces-194197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EECAC7BE7
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 12:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E2F1BC6BFB
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 10:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B4928D8FB;
	Thu, 29 May 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D05mXGGd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313E6288C8D
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515495; cv=none; b=YOEzPQo/ce5lcewB59KV9Si0Fr0EIN+YD/4YumO9YNTaWIVxGXJV+KcXikUGj/FWRYuL5X0FbCIrdL2pfFUuIOZS95Ja/PIvl+XfojtUxRJCijMyRHzuR2GF03BlFD8je+LovXQl4qR+3N0RDPWevWUvJDt/BQZldinQyxsmL7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515495; c=relaxed/simple;
	bh=UpzTEZtoEfD/SFauD8A7W9NMB8qjXlZ8Fhb/jak8vhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3S++G8au7zEAI5z7VpZfHD9HOudsxZ08RvzwlwSZ3EnAE38DAFhRlCV45FufZGDJlhBCI8DlcRgpBVxHjiNgu6nzuCMYDNCNC9TAqiKpe5CIIChmZE4sGtXaqmt3WbXOzlU3PU//ExbIrWGwEYOBHddfkDEdDwbjrJIHLZVtg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D05mXGGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A631C4CEE7;
	Thu, 29 May 2025 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748515494;
	bh=UpzTEZtoEfD/SFauD8A7W9NMB8qjXlZ8Fhb/jak8vhU=;
	h=From:To:Cc:Subject:Date:From;
	b=D05mXGGd5i8Kl2WiJk59mLxfk8nAaNCXKVHz3kYSRwxZyBDJb2OgvxJzJ9zcOcxbX
	 aErIkJbte04vaIkk6pL0F7BbDBhDRarBr8CHqt17a9HEBH66idxnukWYwZ1VIYoi/L
	 Inm2HKXS7y0rlu3ZB/x4pMdh51EDUGI5VB14EXmCpNLRqYwoo8OygemkPa/IFHf6Hl
	 Dxwyc7TTMHB+rQ5fZBHSG3fTYVbwuJH98y4efiAXHNtNOqmRSObbUKDyexujn9D+Ij
	 WEjFIQtHeL4bUlu4/jAp5XzyJcjFV+HFwwgIYT3s0jAGv2C9eXh3dbUR+Pf51K//gJ
	 csrDes7zrz2Ew==
From: Christian Brauner <brauner@kernel.org>
To: Eric Dumazet <edumazet@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	David Rheinsberg <david@readahead.eu>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: af-unix: ECONNRESET with fully consumed out-of-band data
Date: Thu, 29 May 2025 12:37:54 +0200
Message-ID: <20250529-sinkt-abfeuern-e7b08200c6b0@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2846; i=brauner@kernel.org; h=from:subject:message-id; bh=UpzTEZtoEfD/SFauD8A7W9NMB8qjXlZ8Fhb/jak8vhU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRYWM05ci+5rPyX594zK/YZ92TqnZTnymANTT94btaZ6 mPfIgsmdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEL5Lhf6Tjwu1Twl7HdjCW rfDhmaV8eNaZm/ZuPkFMszqtfOIrchgZ/v6f+vjdxm/JMbELeRxjrzv+ttpi3VV9bYrxA/2FR9b LcgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey,

I've played with out-of-band data on unix sockets and I'm observing strange
behavior. Below is a minimal reproducer.

This is sending exactly one byte of out-of-band data from the client to the
server. The client shuts down the write side aftewards and issues a blocking
read waiting for the server to sever the connection.

The server consumes the single byte of out-of-band data sent by the client and
closes the connection.

The client should see a zero read as all data has been consumed but instead it
sees ECONNRESET indicating an unclean shutdown.

But it's even stranger. If the server issues a regular data read() after
consuming the single out-of-band byte it will get a zero read indicating EOF as
the child shutdown the write side. The fun part is that this zero read in the
parent also makes the child itself see a zero read/EOF after the client severs
the connection indicating a clean shutdown. Which makes no sense to me
whatsoever.

In contrast, when sending exactly one byte of regular data the client sees a
zero read aka EOF correctly indicating a clean shutdown.

It seems a bug to me that a single byte of out-of-band data leads to an unclean
shutdown even though it has been correctly consumed and there's no more data
left in the socket.

Maybe that's expected and there's a reasonable explanation but that's very
unexpected behavior.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <errno.h>
#include <sys/wait.h>

int main(void) {
	int sv[2];
	pid_t pid;
	char buf[16];
	ssize_t n;

	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) < 0)
		_exit(EXIT_FAILURE);

	pid = fork();
	if (pid < 0)
		_exit(EXIT_FAILURE);

	if (pid == 0) {
		close(sv[0]);

		/* Send OOB data to the server. */
		printf("child: %zd\n", send(sv[1], "1", 1, MSG_OOB));

		/* We're done sending data so shutdown the write side. */
		shutdown(sv[1], SHUT_WR);

		/* We expect to see EOF here, but we see ECONNRESET instead. */
		if (read(sv[1], buf, 1) != 0) {
			fprintf(stderr, "%d => %m - Child read did not return EOF\n", errno);
			_exit(EXIT_FAILURE);
		}

		_exit(EXIT_SUCCESS);
	}

	/* The parent acts as a client here. */
	close(sv[1]);

	/* Hack: MSG_OOB doesn't block, so we need to make sure the OOB data has arrived. */
	sleep(2);
	
	/* Read the OOB data. */
	printf("%zd\n", recv(sv[0], buf, sizeof(buf), MSG_OOB));

	/* If you uncomment the following code you can make the child see a zero read/EOF: */
	// printf("%zd\n", read(sv[0], buf, sizeof(buf)));

	/*
	 * Close the connection. The child should see EOF but sees ECONNRESET instead...
	 * Try removing MSG_OOB and see how the child sees EOF instead.
	 */
	close(sv[0]);

	waitpid(pid, NULL, 0);
	_exit(EXIT_SUCCESS);
}

