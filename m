Return-Path: <netdev+bounces-190750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828DFAB8991
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C743A7057
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5B01EBFE0;
	Thu, 15 May 2025 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="dwjYS4LT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAAA1E1DE2
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319876; cv=none; b=tseWkDH7Q+9VawzFR1y7gxi8JDGXClfM3rKQzlRYU9ngpbSP/qak2xDExTOHfZEnCoI1AogghfYGiYKpEOPnzCZdl9SzMVrCcSru9v+19vw08DagvI4Wb2zSofvAqKX0xnpBwPekyJkDNWt5Xpvnl+q89cYDBjVW+wFZbkwplN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319876; c=relaxed/simple;
	bh=3X5sko4Nwntj/peXWF9aJDG3UL9bSh5GIx4Fd527vKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNlfBol9lcUz1Et26jfIq/n3CS8Lv5lw0RWe+jGmBxz/mzH8ArtD2HqdDlbz3+0BnCtT1/5JURkYz4mTfg+z+D0eMjPmSwunoxLp17qm98hX3PDBilUCcTJc+mBnug3OgsgemS06ZELvfL64OJ/Up0E4w2GvsNqIwdRVaTlbI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=dwjYS4LT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54e7967cf67so1065772e87.0
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1747319872; x=1747924672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DLWxBncY3MQiODrTcOgN2iyGuvC/s1EoJ4HfsOmMJYE=;
        b=dwjYS4LT2sZAmY0ihlmXYSIg2I8BxZvaDaYXdum6Cpz61xOO2T5fn3uFKWQI93pQwW
         aJjL582NDThd+U9CUIGDUAtI8TTomiegjeP+/6RQ1c1TTPCiRAu69IuG13pvcJ0k8V8D
         RrA78/4Z066Yn54qzB/YRPjK7BY4ploMUPlbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747319872; x=1747924672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLWxBncY3MQiODrTcOgN2iyGuvC/s1EoJ4HfsOmMJYE=;
        b=u3kW9vWZrR43tbts+Wn6mSIhXk3/q2x7rTo5Lv0TKkgeQurFNGub5noXR54dfu1CIn
         21EHXu8kKXzyBT1cmmV8jUhi9vU8EhhSrved2zyiS4gkgx+AuoVh1CQ0wEazI7Oih7qR
         wM07WB6GDGYRG48WdNbtyWBY7nRZSimizC0Ss3bdQMHolftdlJUbj9LVZIRjCAuU/IIQ
         Fq617PTSAfTkqsTZfwTLiIM00TRClGSdwft3xMFwyvti+YS4pUUpm6aN+nlMShArRnUZ
         FlPV9z8kJdr7H19pKHi6aKQJSDGDoHK3Il6OkkgcsyLYuB5utPH7UpnT2ETWwkXltC1I
         kvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVSPlsFMBdQ5v0rNekJi6F9j+EWq8V6lAHz8V4dB4ocpmBQRuk7qC5cNWPmUG/OVJ65Oyt1Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoeIeWIdLdxQ4L/MMwXj0NyS/rF7vW8g13b575TkRYQ8VCtyAS
	1gQzhLlyKis0nWs/wqU3CQypAXhQPfFiJ1hdRpCegQp7WVrZmaduoyhivx/DPzTmDBnr02JUxMu
	a4kUpfeMgvjhwZrBM50ZS1aLOdK21RUdZX/To8Q==
X-Gm-Gg: ASbGncul9PwJPtVmnp8PB5y9XJ9lq8JOib7SzLTCvD7RSC0wLGUslbyaYd/2YFf5ThE
	0qN4tWnrCj5go4ghQ4F5YwAhpig1O6DTjAGiIojrs2RyjX88dKq1VKFteQ0ph+7XNkTWUsR0Jth
	fO24yHlN0R/jeBpejf7IGT3p5NokSbEI7Itg==
X-Google-Smtp-Source: AGHT+IGs+xMJJuCwF4iYMa6FQJdBL8q8BniGjGgSR2O0W6M1de6ueJ35Ugysa/FTuz2YL3zSlBWZAjD7Qf2qdI7LP1w=
X-Received: by 2002:a05:6512:620c:b0:545:e2e:843a with SMTP id
 2adb3069b0e04-550d5fdaf2fmr3073738e87.38.1747319871767; Thu, 15 May 2025
 07:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-9-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-9-0a1329496c31@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 15 May 2025 16:37:40 +0200
X-Gm-Features: AX0GCFtrGV-A5-J_ULGS4Xel3JuBrliCKkWxAO8426zXTklGUPBQJetOa3ixe_w
Message-ID: <CAJqdLrq3sy2LWiRpQtqnFXiONxo4Sx9oC0ZMc3pfRh7TS424ow@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] selftests/coredump: add tests for AF_UNIX coredumps
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Do., 15. Mai 2025 um 00:04 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Add a simple test for generating coredumps via AF_UNIX sockets.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  tools/testing/selftests/coredump/stackdump_test.c | 514 +++++++++++++++++++++-
>  1 file changed, 513 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/testing/selftests/coredump/stackdump_test.c
> index fe3c728cd6be..42ddcf0bdaf2 100644
> --- a/tools/testing/selftests/coredump/stackdump_test.c
> +++ b/tools/testing/selftests/coredump/stackdump_test.c
> @@ -1,14 +1,20 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include <fcntl.h>
> +#include <inttypes.h>
>  #include <libgen.h>
>  #include <linux/limits.h>
>  #include <pthread.h>
>  #include <string.h>
> +#include <sys/mount.h>
>  #include <sys/resource.h>
> +#include <sys/stat.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
>  #include <unistd.h>
>
>  #include "../kselftest_harness.h"
> +#include "../pidfd/pidfd.h"
>
>  #define STACKDUMP_FILE "stack_values"
>  #define STACKDUMP_SCRIPT "stackdump"
> @@ -35,6 +41,7 @@ static void crashing_child(void)
>  FIXTURE(coredump)
>  {
>         char original_core_pattern[256];
> +       pid_t pid_coredump_server;
>  };
>
>  FIXTURE_SETUP(coredump)
> @@ -44,6 +51,7 @@ FIXTURE_SETUP(coredump)
>         char *dir;
>         int ret;
>
> +       self->pid_coredump_server = -ESRCH;
>         file = fopen("/proc/sys/kernel/core_pattern", "r");
>         ASSERT_NE(NULL, file);
>
> @@ -61,10 +69,17 @@ FIXTURE_TEARDOWN(coredump)
>  {
>         const char *reason;
>         FILE *file;
> -       int ret;
> +       int ret, status;
>
>         unlink(STACKDUMP_FILE);
>
> +       if (self->pid_coredump_server > 0) {
> +               kill(self->pid_coredump_server, SIGTERM);
> +               waitpid(self->pid_coredump_server, &status, 0);
> +       }
> +       unlink("/tmp/coredump.file");
> +       unlink("/tmp/coredump.socket");
> +
>         file = fopen("/proc/sys/kernel/core_pattern", "w");
>         if (!file) {
>                 reason = "Unable to open core_pattern";
> @@ -154,4 +169,501 @@ TEST_F_TIMEOUT(coredump, stackdump, 120)
>         fclose(file);
>  }
>
> +TEST_F(coredump, socket)
> +{
> +       int fd, pidfd, ret, status;
> +       FILE *file;
> +       pid_t pid, pid_coredump_server;
> +       struct stat st;
> +       char core_file[PATH_MAX];
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +       const struct sockaddr_un coredump_sk = {
> +               .sun_family = AF_UNIX,
> +               .sun_path = "/tmp/coredump.socket",
> +       };
> +       size_t coredump_sk_len = offsetof(struct sockaddr_un, sun_path) +
> +                                sizeof("/tmp/coredump.socket");
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       file = fopen("/proc/sys/kernel/core_pattern", "w");
> +       ASSERT_NE(file, NULL);
> +
> +       ret = fprintf(file, "@/tmp/coredump.socket");
> +       ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
> +       ASSERT_EQ(fclose(file), 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
> +               __u64 peer_cookie;
> +               socklen_t fd_peer_pidfd_len, peer_cookie_len;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
> +               if (fd_server < 0)
> +                       _exit(EXIT_FAILURE);
> +
> +               ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to bind coredump socket\n");
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               ret = listen(fd_server, 1);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to listen on coredump socket\n");
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "Failed to accept coredump socket connection\n");
> +                       close(fd_server);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               peer_cookie_len = sizeof(peer_cookie);
> +               ret = getsockopt(fd_coredump, SOL_SOCKET, SO_COOKIE,
> +                                &peer_cookie, &peer_cookie_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "%m - Failed to retrieve cookie for coredump socket connection\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
> +               ret = getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD,
> +                                &fd_peer_pidfd, &fd_peer_pidfd_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               memset(&info, 0, sizeof(info));
> +               info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
> +               ret = ioctl(fd_peer_pidfd, PIDFD_GET_INFO, &info);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to retrieve pidfd info from peer pidfd for coredump socket connection\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "Missing coredump information from coredumping task\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (!(info.coredump_mask & PIDFD_COREDUMPED)) {
> +                       fprintf(stderr, "Received connection from non-coredumping task\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (!info.coredump_cookie) {
> +                       fprintf(stderr, "Missing coredump cookie\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (info.coredump_cookie != peer_cookie) {
> +                       fprintf(stderr, "Mismatching coredump cookies\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               fd_core_file = creat("/tmp/coredump.file", 0644);
> +               if (fd_core_file < 0) {
> +                       fprintf(stderr, "Failed to create coredump file\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               for (;;) {
> +                       char buffer[4096];
> +                       ssize_t bytes_read, bytes_write;
> +
> +                       bytes_read = read(fd_coredump, buffer, sizeof(buffer));
> +                       if (bytes_read < 0) {
> +                               close(fd_coredump);
> +                               close(fd_server);
> +                               close(fd_peer_pidfd);
> +                               close(fd_core_file);
> +                               _exit(EXIT_FAILURE);
> +                       }
> +
> +                       if (bytes_read == 0)
> +                               break;
> +
> +                       bytes_write = write(fd_core_file, buffer, bytes_read);
> +                       if (bytes_read != bytes_write) {
> +                               close(fd_coredump);
> +                               close(fd_server);
> +                               close(fd_peer_pidfd);
> +                               close(fd_core_file);
> +                               _exit(EXIT_FAILURE);
> +                       }
> +               }
> +
> +               close(fd_coredump);
> +               close(fd_server);
> +               close(fd_peer_pidfd);
> +               close(fd_core_file);
> +               _exit(EXIT_SUCCESS);
> +       }
> +       self->pid_coredump_server = pid_coredump_server;
> +
> +       EXPECT_EQ(close(ipc_sockets[1]), 0);
> +       ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
> +       EXPECT_EQ(close(ipc_sockets[0]), 0);
> +
> +       pid = fork();
> +       ASSERT_GE(pid, 0);
> +       if (pid == 0)
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_TRUE(WCOREDUMP(status));
> +
> +       info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
> +       ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
> +       ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
> +       ASSERT_GT((info.coredump_mask & PIDFD_COREDUMPED), 0);
> +
> +       waitpid(pid_coredump_server, &status, 0);
> +       self->pid_coredump_server = -ESRCH;
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +
> +       ASSERT_EQ(stat("/tmp/coredump.file", &st), 0);
> +       ASSERT_GT(st.st_size, 0);
> +       /*
> +        * We should somehow validate the produced core file.
> +        * For now just allow for visual inspection
> +        */
> +       system("file /tmp/coredump.file");
> +}
> +
> +TEST_F(coredump, socket_detect_userspace_client)
> +{
> +       int fd, pidfd, ret, status;
> +       FILE *file;
> +       pid_t pid, pid_coredump_server;
> +       struct stat st;
> +       char core_file[PATH_MAX];
> +       struct pidfd_info info = {};
> +       int ipc_sockets[2];
> +       char c;
> +       const struct sockaddr_un coredump_sk = {
> +               .sun_family = AF_UNIX,
> +               .sun_path = "/tmp/coredump.socket",
> +       };
> +       size_t coredump_sk_len = offsetof(struct sockaddr_un, sun_path) +
> +                                sizeof("/tmp/coredump.socket");
> +
> +       file = fopen("/proc/sys/kernel/core_pattern", "w");
> +       ASSERT_NE(file, NULL);
> +
> +       ret = fprintf(file, "@/tmp/coredump.socket");
> +       ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
> +       ASSERT_EQ(fclose(file), 0);
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
> +               __u64 peer_cookie;
> +               socklen_t fd_peer_pidfd_len, peer_cookie_len;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
> +               if (fd_server < 0)
> +                       _exit(EXIT_FAILURE);
> +
> +               ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to bind coredump socket\n");
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               ret = listen(fd_server, 1);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to listen on coredump socket\n");
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               close(ipc_sockets[1]);
> +
> +               fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +               if (fd_coredump < 0) {
> +                       fprintf(stderr, "Failed to accept coredump socket connection\n");
> +                       close(fd_server);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               peer_cookie_len = sizeof(peer_cookie);
> +               ret = getsockopt(fd_coredump, SOL_SOCKET, SO_COOKIE,
> +                                &peer_cookie, &peer_cookie_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "%m - Failed to retrieve cookie for coredump socket connection\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
> +               ret = getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD,
> +                                &fd_peer_pidfd, &fd_peer_pidfd_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               memset(&info, 0, sizeof(info));
> +               info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
> +               ret = ioctl(fd_peer_pidfd, PIDFD_GET_INFO, &info);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to retrieve pidfd info from peer pidfd for coredump socket connection\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
> +                       fprintf(stderr, "Missing coredump information from coredumping task\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (info.coredump_mask & PIDFD_COREDUMPED) {
> +                       fprintf(stderr, "Received unexpected connection from coredumping task\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (info.coredump_cookie) {
> +                       fprintf(stderr, "Received unexpected coredump cookie\n");
> +                       close(fd_coredump);
> +                       close(fd_server);
> +                       close(fd_peer_pidfd);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               close(fd_coredump);
> +               close(fd_server);
> +               close(fd_peer_pidfd);
> +               close(fd_core_file);
> +               _exit(EXIT_SUCCESS);
> +       }
> +       self->pid_coredump_server = pid_coredump_server;
> +
> +       EXPECT_EQ(close(ipc_sockets[1]), 0);
> +       ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
> +       EXPECT_EQ(close(ipc_sockets[0]), 0);
> +
> +       pid = fork();
> +       ASSERT_GE(pid, 0);
> +       if (pid == 0) {
> +               int fd_socket;
> +               ssize_t ret;
> +
> +               fd_socket = socket(AF_UNIX, SOCK_STREAM, 0);
> +               if (fd_socket < 0)
> +                       _exit(EXIT_FAILURE);
> +
> +
> +               ret = connect(fd_socket, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
> +               if (ret < 0)
> +                       _exit(EXIT_FAILURE);
> +
> +               (void *)write(fd_socket, &(char){ 0 }, 1);
> +               close(fd_socket);
> +               _exit(EXIT_SUCCESS);
> +       }
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +
> +       info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
> +       ASSERT_EQ(ioctl(pidfd, PIDFD_GET_INFO, &info), 0);
> +       ASSERT_GT((info.mask & PIDFD_INFO_COREDUMP), 0);
> +       ASSERT_EQ((info.coredump_mask & PIDFD_COREDUMPED), 0);
> +
> +       waitpid(pid_coredump_server, &status, 0);
> +       self->pid_coredump_server = -ESRCH;
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +
> +       ASSERT_NE(stat("/tmp/coredump.file", &st), 0);
> +       ASSERT_EQ(errno, ENOENT);
> +}
> +
> +TEST_F(coredump, socket_enoent)
> +{
> +       int pidfd, ret, status;
> +       FILE *file;
> +       pid_t pid;
> +       char core_file[PATH_MAX];
> +
> +       file = fopen("/proc/sys/kernel/core_pattern", "w");
> +       ASSERT_NE(file, NULL);
> +
> +       ret = fprintf(file, "@/tmp/coredump.socket");
> +       ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
> +       ASSERT_EQ(fclose(file), 0);
> +
> +       pid = fork();
> +       ASSERT_GE(pid, 0);
> +       if (pid == 0)
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_FALSE(WCOREDUMP(status));
> +}
> +
> +TEST_F(coredump, socket_no_listener)
> +{
> +       int pidfd, ret, status;
> +       FILE *file;
> +       pid_t pid, pid_coredump_server;
> +       int ipc_sockets[2];
> +       char c;
> +       const struct sockaddr_un coredump_sk = {
> +               .sun_family = AF_UNIX,
> +               .sun_path = "/tmp/coredump.socket",
> +       };
> +       size_t coredump_sk_len = offsetof(struct sockaddr_un, sun_path) +
> +                                sizeof("/tmp/coredump.socket");
> +
> +       ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
> +       ASSERT_EQ(ret, 0);
> +
> +       file = fopen("/proc/sys/kernel/core_pattern", "w");
> +       ASSERT_NE(file, NULL);
> +
> +       ret = fprintf(file, "@/tmp/coredump.socket");
> +       ASSERT_EQ(ret, strlen("@/tmp/coredump.socket"));
> +       ASSERT_EQ(fclose(file), 0);
> +
> +       pid_coredump_server = fork();
> +       ASSERT_GE(pid_coredump_server, 0);
> +       if (pid_coredump_server == 0) {
> +               int fd_server, fd_coredump, fd_peer_pidfd, fd_core_file;
> +               __u64 peer_cookie;
> +               socklen_t fd_peer_pidfd_len, peer_cookie_len;
> +
> +               close(ipc_sockets[0]);
> +
> +               fd_server = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
> +               if (fd_server < 0)
> +                       _exit(EXIT_FAILURE);
> +
> +               ret = bind(fd_server, (const struct sockaddr *)&coredump_sk, coredump_sk_len);
> +               if (ret < 0) {
> +                       fprintf(stderr, "Failed to bind coredump socket\n");
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
> +                       close(fd_server);
> +                       close(ipc_sockets[1]);
> +                       _exit(EXIT_FAILURE);
> +               }
> +
> +               close(fd_server);
> +               close(ipc_sockets[1]);
> +               _exit(EXIT_SUCCESS);
> +       }
> +       self->pid_coredump_server = pid_coredump_server;
> +
> +       EXPECT_EQ(close(ipc_sockets[1]), 0);
> +       ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
> +       EXPECT_EQ(close(ipc_sockets[0]), 0);
> +
> +       pid = fork();
> +       ASSERT_GE(pid, 0);
> +       if (pid == 0)
> +               crashing_child();
> +
> +       pidfd = sys_pidfd_open(pid, 0);
> +       ASSERT_GE(pidfd, 0);
> +
> +       waitpid(pid, &status, 0);
> +       ASSERT_TRUE(WIFSIGNALED(status));
> +       ASSERT_FALSE(WCOREDUMP(status));
> +
> +       waitpid(pid_coredump_server, &status, 0);
> +       self->pid_coredump_server = -ESRCH;
> +       ASSERT_TRUE(WIFEXITED(status));
> +       ASSERT_EQ(WEXITSTATUS(status), 0);
> +}
> +
>  TEST_HARNESS_MAIN
>
> --
> 2.47.2
>

