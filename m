Return-Path: <netdev+bounces-246119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FB8CDF9E4
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 13:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AD5B302AE17
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 12:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6A031283E;
	Sat, 27 Dec 2025 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YhNuIK7P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30053A1E9C
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837833; cv=none; b=SBU8PLT/FsA2/x6gP5qeLiCr/Y/dWkNvpX43O+3iC4vugHUevaAodkNHm0Ma20zwuwwc4TtUpBEuZQhn1lPUOoLBtx/U8NFMebGUVBiGIXIAAhTFU9TQX6+WciNn/sIi4+VtVG6bZtnuEYuNEEUMoXiTHupJ2K9He/abzwP9kdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837833; c=relaxed/simple;
	bh=neUSae1tSSd9ZUIMhNnIsDOes9ZbVtbWmizb8QV3UdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iEG1fKQ3QcsQ8th44KJfhTesoFUyl8SGga8x55SPH71D5AW0f5cjpcWuA4D+KUvrNtL+aJagBpVaISxTAxayYoc/9P5kT3WyAIVsXEnK9YmazLU9w59gyKnBtYwLaBx4uvGsIpn1xVxh/FcWDWiQNJCdDZcC8I5/IJ5IBVp1v4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YhNuIK7P; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso25747815e9.1
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 04:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837828; x=1767442628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhFoe+/fNVQYtucZwNZBdpwy2GyzZc29S0jBT7dXZmU=;
        b=YhNuIK7PLZN3VHu47lzJ/Z7Ow0iPxc0fh0daoCFxbpLFE74zklgUOfO8V3ZQ/pTYcu
         8RF9ymNP5886FYsLgt6xFnW1vRcEdxuNg0Hze+FivIQlaQznp6dQbuOhossx3D7Qa1+6
         uyE7gsZQL5UB1ox3JM4N652VlrkFfD3eIGaU3lwGhNMaWeNotTetUn/1NwyFa0GCKAnv
         /GdpXPkNQd5o8ZaPQSTdz2TTh6gYeykYVmSzNeHWF6CXqWROaDWGVl3gmSLKKXG5tG9s
         V6lwGIz466OU+54uZYZ7HeRftiMT+7aJq3vjCokr8oedNWji5Gw8iwr03lC1JPiTftbD
         QrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837828; x=1767442628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rhFoe+/fNVQYtucZwNZBdpwy2GyzZc29S0jBT7dXZmU=;
        b=CvjA6Sfeg28usToudR2Jvp+c0Yvj3qbQjNkNC6TRskJNGzLeR3OqoG5y2S7t02J83p
         vLbH9r3yjEPtDb/wQIVHLpO8K4JckMQe7itE7mh3flRmf8HSMqWvkpDCWjudKpya81du
         lFI10cdqSzmBRhb7Uk0A5ky9buGmqt3a9npP5Xk5xYnyVW8h0HTgnJpiXtBwoq00W5wq
         +xkao0NjL0+iIT/W4dGZ8J4wDuNDCSMaBvTYWWvZZ4TD/7AZP++Wdh7SR9oGaQ1HCVET
         4hZ5FQUeec9/YShrvt7u+Rj9ZNvPaNFOyGBg6ij4cq46eoW4Xl8dDFmNgYq5uNAIYUgd
         E38g==
X-Forwarded-Encrypted: i=1; AJvYcCX3+8r9o6rfRPAc7gfnSNlkty1nBvMU/+iN3EPtaa7q07rOTHosOTHeescDhTj2uvCjJJjrfm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC01xcKgp/EzaTvzfkEoZKa0zSBcDv3v3N+5/0nYkv6aNew4bf
	bKnI2bqginVMPV3k/yd0dZu9eb80ndBNsb5XxB5TRQtBxSQDItV8UOG+OJNLS6FFFcw=
X-Gm-Gg: AY/fxX4NLnO+hEhhNTR08FRAXszoMjSfLrS1RFnALHae/wkEKMOii8kgSve39Xg9Dvp
	/qDHaVw+Ab8EZsqN2oW+e0a0wNE4ncrPX6wXrWJr8xmoldtklzvoPU21PLnbSyhc2E7cbN6e5Fw
	cOgiCcyxE8gm0UUtGLE8t6md0d+SPW2auy0vbPm4v4aemYu3EL3bJrYlbvyaFk0KnW2cNZ6DAUP
	lTa7FMJADMOW6DyzRJlURIh8D6MflFuUS61sd1QqF05+uil2WF6T79/RFjbDlSoV8LlOYcQUDQV
	uxLrZ/8x/eY68vxFYhNlHlcfGLtLCwwUoPBD+M5oxo0XmPShRo6S6ArabY9hCByYzhhyNDyq5Hd
	OFiji9+uZIoX0kWxse2wxS3TmBuXfJHqWfHNZg87/mA9tBFQBuAQKux5EPidhi6EvpJCse/sl/r
	l1VTJ/hXrg
X-Google-Smtp-Source: AGHT+IHT9M2beqQrZzp9xbbyJud8/h6Q+UOZtBpjbh3fLwHrPjz2pLTjAJscQz+yaZcvqZw8y6NMSQ==
X-Received: by 2002:a05:600c:3b88:b0:47a:814c:ee95 with SMTP id 5b1f17b1804b1-47d19556cf7mr356539265e9.12.1766837826003;
        Sat, 27 Dec 2025 04:17:06 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:17:05 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:09 -0300
Subject: [PATCH 02/19] printk: Introduce console_is_nbcon
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-2-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=5401;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=neUSae1tSSd9ZUIMhNnIsDOes9ZbVtbWmizb8QV3UdY=;
 b=gCYQ59/fzh5QOgA05PXMV/E/oNmzy4c9swZbzFlKNzJFERHXZDcBlPYBdYFwyrufnetFktUrT
 qugGUjzspdLDAy+AfxtSwqRvBilWtZIJfksSlShjgsgxcBNFgQvlHOk
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

Besides checking if the current console is NBCON or not, console->flags
is also being read in order to serve as argument of the console_is_usable
function.

But CON_NBCON flag is unique: it's set just once in the console
registration and never cleared. In this case it can be possible to read
the flag when console_srcu_lock is held (which is the case when using
for_each_console).

This change makes possible to remove the flags argument from
console_is_usable in the next patches.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h   | 27 +++++++++++++++++++++++++++
 kernel/debug/kdb/kdb_io.c |  2 +-
 kernel/printk/nbcon.c     |  2 +-
 kernel/printk/printk.c    | 15 ++++++---------
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 35c03fc4ed51..dd4ec7a5bff9 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -561,6 +561,33 @@ static inline void console_srcu_write_flags(struct console *con, short flags)
 	WRITE_ONCE(con->flags, flags);
 }
 
+/**
+ * console_srcu_is_nbcon - Locklessly check whether the console is nbcon
+ * @con:	struct console pointer of console to check
+ *
+ * Requires console_srcu_read_lock to be held, which implies that @con might
+ * be a registered console. The purpose of holding console_srcu_read_lock is
+ * to guarantee that no exit/cleanup routines will run if the console
+ * is currently undergoing unregistration.
+ *
+ * If the caller is holding the console_list_lock or it is _certain_ that
+ * @con is not and will not become registered, the caller may read
+ * @con->flags directly instead.
+ *
+ * Context: Any context.
+ * Return: True when CON_NBCON flag is set.
+ */
+static inline bool console_is_nbcon(const struct console *con)
+{
+	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
+
+	/*
+	 * The CON_NBCON flag is statically initialized and is never
+	 * set or cleared at runtime.
+	 */
+	return data_race(con->flags & CON_NBCON);
+}
+
 /* Variant of console_is_registered() when the console_list_lock is held. */
 static inline bool console_is_registered_locked(const struct console *con)
 {
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6ffb962392a4..d6de512b433a 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -596,7 +596,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		if (c == dbg_io_ops->cons)
 			continue;
 
-		if (flags & CON_NBCON) {
+		if (console_is_nbcon(c)) {
 			struct nbcon_write_context wctxt = { };
 
 			/*
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 13865ef85990..f0f42e212caa 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1647,7 +1647,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
 	for_each_console_srcu(con) {
 		short flags = console_srcu_read_flags(con);
 
-		if (!(flags & CON_NBCON))
+		if (!console_is_nbcon(con))
 			continue;
 
 		if (!console_is_usable(con, flags, NBCON_USE_ATOMIC))
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5f4b84f9562e..bd0d574be3cf 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3200,7 +3200,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 		 * nbcon consoles when the nbcon consoles cannot print via
 		 * their atomic or threaded flushing.
 		 */
-		if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
+		if (console_is_nbcon(con) && (ft.nbcon_atomic || ft.nbcon_offload))
 			continue;
 
 		if (!console_is_usable(con, flags,
@@ -3209,7 +3209,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 			continue;
 		any_usable = true;
 
-		if (flags & CON_NBCON) {
+		if (console_is_nbcon(con)) {
 			progress = nbcon_legacy_emit_next_record(con, handover, cookie,
 								 !do_cond_resched);
 			printk_seq = nbcon_seq_read(con);
@@ -3458,7 +3458,6 @@ void console_unblank(void)
 static void __console_rewind_all(void)
 {
 	struct console *c;
-	short flags;
 	int cookie;
 	u64 seq;
 
@@ -3466,9 +3465,7 @@ static void __console_rewind_all(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		flags = console_srcu_read_flags(c);
-
-		if (flags & CON_NBCON) {
+		if (console_is_nbcon(c)) {
 			nbcon_seq_force(c, seq);
 		} else {
 			/*
@@ -3632,13 +3629,13 @@ static bool legacy_kthread_should_wakeup(void)
 		 * consoles when the nbcon consoles cannot print via their
 		 * atomic or threaded flushing.
 		 */
-		if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
+		if (console_is_nbcon(con) && (ft.nbcon_atomic || ft.nbcon_offload))
 			continue;
 
 		if (!console_is_usable(con, flags, NBCON_USE_THREAD))
 			continue;
 
-		if (flags & CON_NBCON) {
+		if (console_is_nbcon(con)) {
 			printk_seq = nbcon_seq_read(con);
 		} else {
 			/*
@@ -4490,7 +4487,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (!console_is_usable(c, flags, NBCON_USE_ANY))
 				continue;
 
-			if (flags & CON_NBCON) {
+			if (console_is_nbcon(c)) {
 				printk_seq = nbcon_seq_read(c);
 			} else {
 				printk_seq = c->seq;

-- 
2.52.0


