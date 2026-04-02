Return-Path: <netdev+bounces-274622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP1qMI6XzmkBowYAu9opvQ
	(envelope-from <netdev+bounces-274622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:21:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF638BC6D
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3FFD301DB7B
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55603EFD1B;
	Thu,  2 Apr 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="JuvIwXUP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A6leeqYO"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F4C3D3CEA
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146886; cv=none; b=a0eOvq6GEUVbQwxYrNBbOS4qYsuCdT4Wlw1Rrm5wC3Pjw0q1NWmD+BXr+SBQ/bPcQOIDyPDmn97sWy2soOBCKazLyB1Vtdpy0XxrrIDjpc11+H+5v8Io8MeUI74uHpgSnAj6SfpRY1BXqfy/Cp9fIGhQfHph8uyvo8Dg6jd7Tjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146886; c=relaxed/simple;
	bh=OQqVAZertr0MqEb4OL9FMHWJmK0TnhI0czbi30Fs8yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DY1TDBeX2b/Xm0+ddu8bWxGYBF5eghbQvsUt3SYjqFzLixQMkBBGuSDbgXW5+DL6YC/4DY+aG5ajkdLUkzk0n9fjDSIpXxFQ88HaODQweanWebhL+sjXctjKdkZdviyECGs7hoY4etXbjvPvobnVIaUaVtZImppmWFqqhVdgozU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=JuvIwXUP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A6leeqYO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 231A8EC001C;
	Thu,  2 Apr 2026 12:21:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 12:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775146880; x=
	1775233280; bh=vsfWwIb2twbOqOZFXB1PpTJUU05T9jTZgiPsUAhT/RM=; b=J
	uvIwXUP4IrrJgWWIMvJmfrekiag21KD0mkldObzcd7t+JzlRFUkZIn9Vm282B1JV
	ECrCSfGb9xSMnz2fiW00LDR9G59EcJbVTyoWQGWm1qAjjtb1O+2NktfczsfWfSMV
	h0qxQwB6a4NwKX8jNKFIYpsP+RrVfFpq5CoRkHoEfaR5uLIwULl3wWWY3YdmLqj4
	7/faJXmvtnrPg4S9NXBT32fZZYj1HWQTLerm67I8yMj4vZrY8sRluEbOaFSj2ASQ
	vAesA1zY2jY2tnfVolMO+98c0edyDhhFS800u/NH3akz3b81e/DtHsYQ/n0vxvUT
	HAYYvP8wId4xYreDXfnKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775146880; x=1775233280; bh=vsfWwIb2twbOqOZFXB1PpTJUU05T9jTZgiP
	sUAhT/RM=; b=A6leeqYO9btL4yHlQUAjMJGw4D8YYIqq20U0m6UjndKOnfnMrfl
	XYPS2uETUv3Jy8k4L9QbFZ3w4BW8MtgUidgdk05ngC9/ccqgJevHzDaBhJTDkts6
	yA6+P4GPufBDS2FQ7z4PMaBRGrPxX7SIwZMNCQ0r7ZU31/mq8uLEU8JkN/wdsSFp
	2tFIUNvobc5X9kDm18uaFiaWa0EEkO5XmsPUbZi5Tf65YIagsqurF5jlLH8HvwzP
	T4gAOW3JZLrKdXEXM7WJ03n9AQa0O1CChkPNUVi7VO9AKq6j8aZH7yn3PlmjFR6q
	cc6hUdX66ttFDClDpsoQKAgH199PcaUAMXQ==
X-ME-Sender: <xms:f5fOae7RktMnPV4grTsldQGjypkoAtKSr_E_5rRwpJvSxDWNCBAunw>
    <xme:f5fOaTuhuKYdXbsBGI3EoC4dObAY5z6M5j509iRb9sRGsKDt1aa8NxRnMdG7h7oX8
    SQdiuY7uhxZsfBSU9SUnjwvvFSPoZ3lrQbvG5OZl2DqD_6mLTao54I>
X-ME-Received: <xmr:f5fOaY3hLHK8MZUap-UwJRLle1a7kxBjQO8el33odL_Jlot5OW3rd5UgQqFa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeihedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepgefhieehffdvfeetledugfekieevtdeileekgfeliedvgefhkeetudeftdfg
    ieetnecuffhomhgrihhnpehvrghrihgrnhhtshdrthhoohhlshenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghi
    lhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehrjhgvthhhfigrnhhisehpuhhrvghsthhorhgrghgvrdgtohhmpdhrtghpthht
    ohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrvg
    gvughmsehnvhhiughirgdrtghomhdprhgtphhtthhopehtrghrihhqthesnhhvihguihgr
    rdgtohhmpdhrtghpthhtohepmhgslhhotghhsehnvhhiughirgdrtghomhdprhgtphhtth
    hopegsohhrihhsphesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhohhhnrdhfrghs
    thgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
X-ME-Proxy: <xmx:f5fOaUr0alaDtciFCXXpxA_eGgwd1CS3Vt2tCrn9lWqXmUYzpONZiw>
    <xmx:f5fOaQIWx4kRrg5DcGRRAVuxN_C5GZjjRoSYtnmvOaa7x7N8JG-EMQ>
    <xmx:f5fOaYT8YLizuXPohAiAlEs6OvmBJQ82GfOOQEg5KiNpLwNbC6OqhA>
    <xmx:f5fOaQMqc69ZVpjFh0Ev9JIjImkBkFWdQzKXli9BNTJjYyrJgQgV0w>
    <xmx:gJfOacvH9WzngM4s5uUMUyRAGJjggBbAWs_nto5DeHevtrj1kjhyOS7j>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 12:21:19 -0400 (EDT)
Date: Thu, 2 Apr 2026 18:21:17 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v11 6/6] selftests: net: add TLS hardware offload test
Message-ID: <ac6XfZJ9I6itcXxE@krikkit>
References: <20260331163757.149343-1-rjethwani@purestorage.com>
 <20260331163757.149343-7-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331163757.149343-7-rjethwani@purestorage.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274622-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,davemloft.net,redhat.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2ACF638BC6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-31, 10:37:57 -0600, Rishikesh Jethwani wrote:
> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
> new file mode 100644
> index 000000000000..69ee834bfabd
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
[...]
> +static int do_rekey;
> +static int num_rekeys = 1;
> +static int rekeys_done;
> +static int cipher_type = 128;
> +static int tls_version = 13;

You could directly use the uapi constants (TLS_1_3_VERSION,
TLS_CIPHER_AES_GCM_128) instead of coming up with your own.

> +static int server_port = 4433;
> +static char *server_ip;
> +static int addr_family = AF_INET;
> +
> +static int send_size = 16384;
> +static int random_size_max;
> +
> +static int detect_addr_family(const char *ip)

The python code only runs IPv4 tests.
(do_client, do_server, and main also have some v6 stuff that will
never get used)


[...]
> +static void derive_key_256(struct tls12_crypto_info_aes_gcm_256 *key,
> +			   int generation)

That's almost an exact c/p of derive_key_128, except for a few s/128/256/.


[...]
> +/* Send TLS 1.3 KeyUpdate handshake message */
> +static int send_tls_key_update(int fd, int request_update)
> +{
> +	char cmsg_buf[CMSG_SPACE(sizeof(unsigned char))];
> +	unsigned char key_update_msg[5];
> +	struct msghdr msg = {0};
> +	struct cmsghdr *cmsg;
> +	struct iovec iov;
> +
> +	key_update_msg[0] = TLS_HANDSHAKE_KEY_UPDATE;
> +	key_update_msg[1] = 0;
> +	key_update_msg[2] = 0;
> +	key_update_msg[3] = 1;
> +	key_update_msg[4] = request_update ? KEY_UPDATE_REQUESTED
> +					   : KEY_UPDATE_NOT_REQUESTED;

All callers are already passing KEY_UPDATE_REQUESTED or
KEY_UPDATE_NOT_REQUESTED. But I'm not sure why you're bothering with
this, since the RX side only checks buf[0] == TLS_HANDSHAKE_KEY_UPDATE.

[...]
> +static int recv_tls_message(int fd, char *buf, size_t buflen, int *record_type)
> +{
> +	char cmsg_buf[CMSG_SPACE(sizeof(unsigned char))];
> +	struct msghdr msg = {0};
> +	struct cmsghdr *cmsg;
> +	struct iovec iov;
> +	int ret;
> +
> +	iov.iov_base = buf;
> +	iov.iov_len = buflen;
> +
> +	msg.msg_iov = &iov;
> +	msg.msg_iovlen = 1;
> +	msg.msg_control = cmsg_buf;
> +	msg.msg_controllen = sizeof(cmsg_buf);
> +
> +	ret = recvmsg(fd, &msg, 0);
> +	if (ret <= 0)
> +		return ret;
> +
> +	*record_type = TLS_RECORD_TYPE_APPLICATION_DATA;  /* default */

Is a default value actually needed? When userspace provides cmsg
space, tls_sw_recvmsg always fills it.

> +	cmsg = CMSG_FIRSTHDR(&msg);
> +	if (cmsg && cmsg->cmsg_level == SOL_TLS &&
> +	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE)
> +		*record_type = *((unsigned char *)CMSG_DATA(cmsg));
> +
> +	return ret;
> +}

[...]
> +static void check_ekeyexpired(int fd)
> +{
> +	char buf[16];
> +	int ret;
> +
> +	ret = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
> +	if (ret == -1 && errno == EKEYEXPIRED)
> +		printf("recv() returned EKEYEXPIRED as expected\n");
> +	else if (ret == -1 && errno == EAGAIN)
> +		printf("recv() returned EAGAIN (no pending data)\n");
> +	else if (ret == -1)
> +		printf("recv() returned error: %s\n", strerror(errno));

Nothing for "we expected EKEYEXPIRED but actually got data"?

And this is only for logging/debugging? It's not having on impact on
the pass/fail results.

> +}
> +
> +static int do_tls_rekey(int fd, int is_tx, int generation, int cipher)

That's almost exact c/p of setup_tls_key. Please clean up all this
duplicated code.

[...]
> +static int do_client(void)
> +{
> +	struct sockaddr_storage sa;
> +	char *buf = NULL, *echo_buf = NULL;
> +	int max_size, rekey_interval;
> +	ssize_t echo_total, echo_n;
> +	int csk = -1, ret, i, j;
> +	int test_result = 0;
> +	int current_gen = 0;
> +	int next_rekey_at;
> +	socklen_t sa_len;
> +	ssize_t n;
> +
> +	if (!server_ip) {
> +		printf("ERROR: Client requires -s <ip> option\n");
> +		return -1;
> +	}
> +
> +	max_size = random_size_max > 0 ? random_size_max : send_size;
> +	if (max_size < MIN_BUF_SIZE)
> +		max_size = MIN_BUF_SIZE;
> +	buf = malloc(max_size);
> +	echo_buf = malloc(max_size);
> +	if (!buf || !echo_buf) {
> +		printf("failed to allocate buffers\n");
> +		test_result = -1;
> +		goto out;
> +	}
> +
> +	csk = socket(addr_family, SOCK_STREAM, IPPROTO_TCP);
> +	if (csk < 0) {
> +		printf("failed to create socket: %s\n", strerror(errno));
> +		test_result = -1;
> +		goto out;
> +	}
> +
> +	memset(&sa, 0, sizeof(sa));
> +	if (addr_family == AF_INET6) {

This will never get used.

[...]

> +	if (setup_tls_key(csk, 1, 0, cipher_type) < 0 ||
> +	    setup_tls_key(csk, 0, 0, cipher_type) < 0) {

This could just use TLS_TX/TLS_RX directly instead of is_tx={0,1}.

> +		test_result = -1;
> +		goto out;
> +	}
> +
> +	if (do_rekey)
> +		printf("TLS %s setup complete. Will perform %d rekey(s).\n",
> +		       cipher_name(cipher_type), num_rekeys);
> +	else
> +		printf("TLS setup complete.\n");
> +
> +	if (random_size_max > 0)
> +		printf("Sending %d messages of random size (1..%d bytes)...\n",
> +		       TEST_ITERATIONS, random_size_max);
> +	else
> +		printf("Sending %d messages of %d bytes...\n",
> +		       TEST_ITERATIONS, send_size);
> +
> +	rekey_interval = TEST_ITERATIONS / (num_rekeys + 1);
> +	if (rekey_interval < 1)
> +		rekey_interval = 1;
> +	next_rekey_at = rekey_interval;
> +
> +	for (i = 0; i < TEST_ITERATIONS; i++) {
> +		int this_size;
> +
> +		if (random_size_max > 0)
> +			this_size = (rand() % random_size_max) + 1;
> +		else
> +			this_size = send_size;
> +
> +		for (j = 0; j < this_size; j++)
> +			buf[j] = rand() & 0xFF;
> +
> +		n = send(csk, buf, this_size, 0);
> +		if (n != this_size) {
> +			printf("FAIL: send failed: %s\n", strerror(errno));
> +			test_result = -1;
> +			break;
> +		}
> +		printf("Sent %zd bytes (iteration %d)\n", n, i + 1);
> +
> +		echo_total = 0;
> +		while (echo_total < n) {
> +			echo_n = recv(csk, echo_buf + echo_total,
> +				      n - echo_total, 0);
> +			if (echo_n < 0) {
> +				printf("FAIL: Echo recv failed: %s\n",
> +				       strerror(errno));
> +				test_result = -1;
> +				break;
> +			}
> +			if (echo_n == 0) {
> +				printf("FAIL: Connection closed during echo\n");
> +				test_result = -1;
> +				break;
> +			}
> +			echo_total += echo_n;
> +		}
> +		if (test_result != 0)
> +			break;

nit: replacing the breaks from the echo_total loop with gotos would be
more readable than this double break (but then it probably makes sense
to also replace all the "test_result = -1; break;" from the whole
TEST_ITERATIONS loop)

> +
> +		if (memcmp(buf, echo_buf, n) != 0) {
> +			printf("FAIL: Echo data mismatch!\n");
> +			test_result = -1;
> +			break;
> +		}
> +		printf("Received echo %zd bytes (ok)\n", echo_total);
> +
> +		/* Rekey at intervals: send KeyUpdate, update TX, recv KeyUpdate, update RX */
> +		if (do_rekey && rekeys_done < num_rekeys &&
> +		    (i + 1) == next_rekey_at) {
> +			current_gen++;
> +			printf("\n=== Client Rekey #%d (gen %d) ===\n",
> +			       rekeys_done + 1, current_gen);

If I'm reading this loop correctly, rekeys_done+1 is always equal to
current_gen here, since we'll either break out or also increment
rekeys_done at the end of the block.  (same in do_server)

[...]
> +static int do_server(void)
> +{
> +	struct sockaddr_storage sa;
> +	int lsk = -1, csk = -1, ret;
> +	ssize_t n, total = 0, sent;
> +	int current_gen = 0;
> +	int test_result = 0;
> +	int recv_count = 0;
> +	char *buf = NULL;
> +	int record_type;
> +	socklen_t sa_len;
> +	int max_size;
> +	int one = 1;
> +
> +	max_size = random_size_max > 0 ? random_size_max : send_size;

The server side is always reading max_size if it can. Just skip the
"random" on server? Otherwise make it receive and echo back random
amounts of bytes at each iteration.

[...]
> +	/* Main receive loop - detect KeyUpdate via MSG_PEEK + recvmsg */
> +	while (1) {
> +		n = recv(csk, buf, max_size, MSG_PEEK | MSG_DONTWAIT);
> +		if (n < 0 &&
> +		    (errno == EIO || errno == ENOMSG || errno == EAGAIN)) {

I don't think ktls ever produces ENOMSG.

> +			n = recv_tls_message(csk, buf, max_size, &record_type);
> +		} else if (n > 0) {
> +			n = recv_tls_message(csk, buf, max_size, &record_type);

Why the PEEK if you're always going to call recv_tls_message afterwards?

> +		} else if (n == 0) {
> +			printf("Connection closed by client\n");
> +			break;
> +		}
> +
> +		if (n <= 0) {
> +			if (n < 0)
> +				printf("recv failed: %s\n", strerror(errno));
> +			break;
> +		}
> +
> +		/* Handle KeyUpdate: update RX, send response, update TX */
> +		if (record_type == TLS_RECORD_TYPE_HANDSHAKE &&
> +		    n >= 1 && buf[0] == TLS_HANDSHAKE_KEY_UPDATE) {

We just excluded n <= 0, so n >= 1 is always true here.

[...]
> +		sent = send(csk, buf, n, 0);
> +		if (sent < 0) {
> +			printf("Echo send failed: %s\n", strerror(errno));
> +			break;
> +		}
> +		if (sent != n)
> +			printf("Echo partial: %zd of %zd bytes\n", sent, n);

If this happens, the client will fall out of sync with the server and
get stuck in the "echo_total < n" loop?

> +		printf("Echoed %zd bytes back to client\n", sent);
> +	}
> +
> +	printf("Connection closed. Total received: %zd bytes\n", total);
> +	if (do_rekey)
> +		printf("Rekeys completed: %d\n", rekeys_done);
> +
> +out:
> +	if (csk >= 0)
> +		close(csk);
> +	if (lsk >= 0)
> +		close(lsk);
> +	free(buf);
> +	return test_result;
> +}
> +
> +static void parse_rekey_option(const char *arg)
> +{
> +	int requested;
> +
> +	if (strncmp(arg, "--rekey=", 8) == 0) {
> +		requested = atoi(arg + 8);
> +		if (requested < 1) {
> +			printf("WARNING: Invalid rekey count, using 1\n");
> +			num_rekeys = 1;
> +		} else if (requested > MAX_REKEYS) {
> +			printf("WARNING: Rekey count %d > max %d, using %d\n",
> +			       requested, MAX_REKEYS, MAX_REKEYS);

Why not just abort the test if we get invalid input? When called
through the python wrapper we'll never get broken arguments, and if
invoked manually I think it's better to abort than do something
semi-random.

> +			num_rekeys = MAX_REKEYS;
> +		} else {
> +			num_rekeys = requested;
> +		}
> +		do_rekey = 1;
> +	} else if (strcmp(arg, "--rekey") == 0) {

The python wrapper never uses that.

> +		do_rekey = 1;
> +		num_rekeys = 1;
> +	}
> +}
> +

[...]
> +static void print_usage(const char *prog)
> +{
> +	printf("TLS Hardware Offload Two-Node Test\n\n");
> +	printf("Usage:\n");
> +	printf("  %s server [OPTIONS]\n", prog);
> +	printf("  %s client -s <ip> [OPTIONS]\n", prog);
> +	printf("\nOptions:\n");
> +	printf("  -s <ip>       Server IP to connect (client, required)\n");
> +	printf("                Supports both IPv4 and IPv6 addresses\n");
> +	printf("  -6            Use IPv6 (server only, default: IPv4)\n");
> +	printf("  -p <port>     Server port (default: 4433)\n");
> +	printf("  -b <size>     Send buffer (record) size (default: 16384)\n");

nit: not record sizes since this can go beyond the maximum record
size.


> +	printf("  -r <max>      Use random send buffer sizes (1..<max>)\n");
> +	printf("  -v <version>  TLS version: 1.2 or 1.3 (default: 1.3)\n");
> +	printf("  -c <cipher>   Cipher: 128 or 256 (default: 128)\n");
> +	printf("  --rekey[=N]   Enable rekey (default: 1, TLS 1.3 only)\n");
> +	printf("  --help        Show this help message\n");
> +	printf("\nExample (IPv4):\n");
> +	printf("  Node A: %s server\n", prog);
> +	printf("  Node B: %s client -s 192.168.20.2\n", prog);
> +	printf("\nExample (IPv6):\n");
> +	printf("  Node A: %s server -6\n", prog);
> +	printf("  Node B: %s client -s 2001:db8::1\n", prog);
> +	printf("\nRekey Example (3 rekeys, TLS 1.3 only):\n");
> +	printf("  Node A: %s server --rekey=3\n", prog);
> +	printf("  Node B: %s client -s 192.168.20.2 --rekey=3\n", prog);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int i;
> +
> +
> +	for (i = 1; i < argc; i++) {
> +		if (strcmp(argv[i], "--help") == 0 ||
> +		    strcmp(argv[i], "-h") == 0) {
> +			print_usage(argv[0]);
> +			return 0;
> +		}
> +	}
> +
> +	for (i = 1; i < argc; i++) {

I'm not a huge fan of getopt(3) but... please use it.

[...]
> +	if (tls_version == 12 && do_rekey) {
> +		printf("WARNING: TLS 1.2 does not support rekey\n");

I'd also abort the test here.



[...]
> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> new file mode 100755
> index 000000000000..5d14cb7d2e3c
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> @@ -0,0 +1,281 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""Test kTLS hardware offload using a C helper binary."""
> +
> +from lib.py import ksft_run, ksft_exit, ksft_pr, KsftSkipEx, ksft_true
> +from lib.py import NetDrvEpEnv
> +from lib.py import cmd, bkg, wait_port_listen, rand_port
> +import time
> +
> +
> +def check_tls_support(cfg):
> +    try:
> +        cmd("test -f /proc/net/tls_stat")
> +        cmd("test -f /proc/net/tls_stat", host=cfg.remote)
> +    except Exception as e:
> +        raise KsftSkipEx(f"kTLS not supported: {e}")
> +
> +
> +def read_tls_stats():
> +    stats = {}
> +    output = cmd("cat /proc/net/tls_stat")
> +    for line in output.stdout.strip().split('\n'):
> +        parts = line.split()
> +        if len(parts) == 2:
> +            stats[parts[0]] = int(parts[1])
> +    return stats
> +
> +
> +def verify_tls_counters(stats_before, stats_after, expected_rekeys, is_server):
> +    tx_device_diff = (stats_after.get('TlsTxDevice', 0) -
> +                      stats_before.get('TlsTxDevice', 0))

Not a big python person, but maybe use defaultdict to make this a bit
more readable?

> +    rx_device_diff = (stats_after.get('TlsRxDevice', 0) -
> +                      stats_before.get('TlsRxDevice', 0))
> +    tx_sw_diff = (stats_after.get('TlsTxSw', 0) -
> +                  stats_before.get('TlsTxSw', 0))
> +    rx_sw_diff = (stats_after.get('TlsRxSw', 0) -
> +                  stats_before.get('TlsRxSw', 0))
> +    decrypt_err_diff = (stats_after.get('TlsDecryptError', 0) -
> +                        stats_before.get('TlsDecryptError', 0))
> +
> +    used_tx_hw = tx_device_diff >= 1
> +    used_rx_hw = rx_device_diff >= 1
> +    used_tx_sw = tx_sw_diff >= 1
> +    used_rx_sw = rx_sw_diff >= 1
> +
> +    errors = 0
> +
> +    role = 'Server' if is_server else 'Client'
> +    ksft_pr(f"=== Counter Verification ({role}) ===")
> +
> +    tx_dev_before = stats_before.get('TlsTxDevice', 0)
> +    tx_dev_after = stats_after.get('TlsTxDevice', 0)
> +    ksft_pr(f"TlsTxDevice: {tx_dev_before} -> {tx_dev_after} "
> +            f"(diff: {tx_device_diff})")
> +
> +    tx_sw_before = stats_before.get('TlsTxSw', 0)
> +    tx_sw_after = stats_after.get('TlsTxSw', 0)
> +    ksft_pr(f"TlsTxSw: {tx_sw_before} -> {tx_sw_after} "
> +            f"(diff: {tx_sw_diff})")

I don't know how nice we want the selftest code to be but... this
whole function is just the same "get before/get after/diff/print"
repeated all over. Please clean this up.


[...]
> +def run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=0, buffer_size=None, random_max=None):
> +    port = rand_port()
> +
> +    server_cmd = f"{cfg.bin_remote} server -p {port} -c {cipher} -v {tls_version}"
> +    if rekey > 0:
> +        server_cmd += f" --rekey={rekey}"

The rekey option has no effect on the server side.

[...]
> +def read_tls_stats_remote(cfg):
> +    stats = {}
> +    output = cmd("cat /proc/net/tls_stat", host=cfg.remote)
> +    for line in output.stdout.strip().split('\n'):
> +        parts = line.split()
> +        if len(parts) == 2:
> +            stats[parts[0]] = int(parts[1])
> +    return stats

And that's again almost exactly a c/p of read_tls_stats().


> +def test_tls_offload_basic(cfg):
> +    cfg.require_ipver("4")
> +    check_tls_support(cfg)
> +    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=0)
> +
> +
> +def test_tls_offload_aes256(cfg):
> +    cfg.require_ipver("4")
> +    check_tls_support(cfg)
> +    run_tls_test(cfg, cipher="256", tls_version="1.3", rekey=0)

Looks like you want test variants.

(tools/testing/selftests/drivers/net/README.rst "ksft_variants")


-- 
Sabrina

