Return-Path: <netdev+bounces-276651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KXWG2GG1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:46:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB40F3BF0C1
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22F3E300D921
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F483D1CB4;
	Wed,  8 Apr 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="fQ+trrHC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ClADOPbr"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE03E2C0285
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666760; cv=none; b=jw2VlmTftrqTuNToI1yVALtEHPvN4VY9adQNY27xIk7Z7E3BUOHq9lhg66fdQK0DjWnO1uLNAOoBPwFteTWiEhqFSJBH2BNiGvJF5K+Nkobf3OwevJzEF9qYNCs7TbHrTcne23zYzEcxYgfjoDx4aveCqUy01F8gGHFe2oIv+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666760; c=relaxed/simple;
	bh=o6hQLxGINIJWQmOwHJp1wrTvq8AkCxA5/7vNkUro9vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz4cpWe6Dj+DJ8C5eGvKca5GwBUpkcVuE7cRP9juiMcCmj271dA2h73l8rH+L0oJ9LIV6m0KfdFfWXIsba/v/w3FuzCIUqk1cGmP8qAJ2Y62m/3rYxOEPen9KtoHtCQ+vrca6eqSAJ2pzstDcLaQFjI+OPh+uoGZXYDEkOqVni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=fQ+trrHC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ClADOPbr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3FE514001F0;
	Wed,  8 Apr 2026 12:45:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 08 Apr 2026 12:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1775666755; x=
	1775753155; bh=4IP8uDhWseAbvSmCO6OndS1adKHMIb/bGpe8jjSwMgs=; b=f
	Q+trrHC3nltjk1l9n33k3Bn8QZpIUtVGQfnybFRxdbn5p67fFAMqf/NnsCNRG1HP
	mi5NKL1BmBN223YOG5R9hD0G1ag2gNFsYykBcIleZrSrIzJWJPMJVOslb+1SbRvL
	L7AXO5AFI2aaA0TiBCJk19JGqusiOGH80SJzXzgQTrQqMDxSabwPnCxMtWD/7fPf
	l5iDOI36hP0Ug+B5h5i7/qEP2w98EAwPYRvZiyow8rXATNEkRltJ4l8Hf/bmiQ9K
	8LTGgrDxy4JRpYv3KvxRWLWLrMVBaEgRjow+3eGU54woGar6WeRkvGYDAhBwCdiq
	UXlNFtTOOFqh6F5tByvVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775666755; x=1775753155; bh=4IP8uDhWseAbvSmCO6OndS1adKHMIb/bGpe
	8jjSwMgs=; b=ClADOPbrWMHHXZ6QibmOmp88HBCg3XGO9wXg0Wxhn1bv1qDQLeN
	7/0WQRyIsS3yFwMcsnD5d5+MGbDoSFTJC18ZqcdKKPblXvW/MKQEKGIol9/4qtrn
	HX2sJbFqL4B+wkRH1JVRFKiie5o/0V4AeKFOf3IgYLEWbmXYRovHJMvnCuFW1aHN
	Z1LXfWaqBf6hUpjQoioG5xMA1/UFBty1pHlYwQNQczWHnn/6vg6FV0IwsSWMJqkC
	H/WPYQUByaJIs3QQTReTP9Yy+zJ50PuB7lLaTd3LKbzK0MzXqNW0Je507CwODidH
	zYBPW0g8Kx4hm7rDOws7RvskD7akiuhdvbw==
X-ME-Sender: <xms:Q4bWaUBzE5DFt0VEAmVCuyRIoIDMkJgUtGXQMD3YNZ8g12y_zhxmRQ>
    <xme:Q4bWaSX9BE6Oia4drWbiYIy-YaK-Frx-DzP_5W32p_Q0lARTrUt5TXK6egy6EDI5O
    SwvOqnI37zWadJQCp7udubr85bKQy3C5ryYU5jYp866-JDrRKpoRI0>
X-ME-Received: <xmr:Q4bWaS9A_O8ISBm1QH6ocX8feQC_D2goXBFlJDIDEi1T8iDfGQmC5QofAXTE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeejkeelveelkeefgfeuheevjeeukedvhedvueegvdekleeghfelgeeiveff
    tdeuudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhjvghthhifrghnihesphhurhgvshhtohhrrghgvgdrtghomhdprhgtphht
    thhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrg
    gvvggumhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepthgrrhhiqhhtsehnvhhiughi
    rgdrtghomhdprhgtphhtthhopehmsghlohgthhesnhhvihguihgrrdgtohhmpdhrtghpth
    htohepsghorhhishhpsehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhhnhdrfhgr
    shhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvg
    hmlhhofhhtrdhnvght
X-ME-Proxy: <xmx:Q4bWaUTLE_B9-BIXeZo_aO_NwwHC5DyCTA58-D1BOr2duX3M7yfcUg>
    <xmx:Q4bWaXQ6R6LTAJ-NtjfFiGoOXLvqUEbFsaXreZP1uwgrCB_oGVJV4w>
    <xmx:Q4bWaQ7txrxEDmQ1P3GwnIhXtSgH-3VC_GyFCkCC1htLX_RO5A5nYw>
    <xmx:Q4bWacWQLpB2ZYY20BA40olLIYaMK6s8HDuzbJnREQJE1ZjLW5QKUA>
    <xmx:Q4bWaZjn0BfORaTFACfc5dDHTxVog6-duHwcLqdCEX1HkPm9Lxgl7oQg>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 12:45:55 -0400 (EDT)
Date: Wed, 8 Apr 2026 18:45:53 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: kuba@kernel.org, Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	leon@kernel.org
Subject: Re: [PATCH v12 6/6] selftests: net: add TLS hardware offload test
Message-ID: <adaGQRUUNbXWXNgP@krikkit>
References: <20260402235511.664801-1-rjethwani@purestorage.com>
 <20260402235511.664801-7-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402235511.664801-7-rjethwani@purestorage.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276651-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,davemloft.net,redhat.com,google.com,kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Queue-Id: AB40F3BF0C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

@Jakub [top-posting so you don't have to scroll through the rest of my
comments to find some global questions about this patch]

tools/testing/selftests/drivers/net/README.rst mentions "Local
host is the DUT", but this test does rekeys on both sides and sends a
bit of traffic back and forth. Is that acceptable?

Another thought: is there a "standard" for stdout vs stderr, as well as
verbosity of "test progress"/"debug" type messages ("sent
keyupdate"/"received keyupdate"/"server listening"/"setup complete"
etc) for those test programs? Any expectation for a --{debug,verbose}
option to only display all this stuff on request?

Output for 1 test:
-------- 8< --------
TLS Version: TLS 1.3
Cipher: AES-GCM-128
Buffer size: 16384
Connecting to 192.168.13.1:4433...
Connected!
Installing TLS_TX AES-GCM-128 gen 0...
TLS_TX AES-GCM-128 gen 0 installed
Installing TLS_RX AES-GCM-128 gen 0...
TLS_RX AES-GCM-128 gen 0 installed
TLS setup complete.
Sending 100 messages of 16384 bytes...
Sent 16384 bytes (iteration 1)
Received echo 16384 bytes (ok)
[...repeated]
Sent 16384 bytes (iteration 100)
Received echo 16384 bytes (ok)
-------- 8< --------

With some rekeys I get 300L of output on each side.


If not, I guess we can fall back to what makes the most sense for
NIPA?



2026-04-02, 17:55:11 -0600, Rishikesh Jethwani wrote:
> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
> new file mode 100644
> index 000000000000..788891890ec8
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c

I think it would make sense to add the new files to the
"NETWORKING [TLS]" entry in MAINTAINERS. We already have the existing
selftest listed.

[...]
> +#define TEST_ITERATIONS	100
> +#define MAX_REKEYS	99

Making TEST_ITERATIONS a test argument would allow a test that lasts
more than half a second. Then MAX_REKEYS can be removed and the
argument validation switched to num_rekeys < num_iterations. (doing
rekeys without a send() in between [other than the send_keyupdate]
should be fine, but it makes the logic for "do we send a rekey and/or
application_data this round?" more complex, so let's keep the check on
num_rekeys)

In general, this test is a good start, but it doesn't cover enough
(see my reply to 5/6). How did you test the "unacked records" part of
the rekey patch? It's the most complex part of the series.


[...]
> +static void derive_key_fields(unsigned char *key, int key_size,
> +			      unsigned char *iv, int iv_size,
> +			      unsigned char *salt, int salt_size,
> +			      unsigned char *rec_seq, int rec_seq_size,
> +			      int generation)
> +{
> +	unsigned char pattern;
> +	int i;
> +
> +	if (generation == 0)
> +		return;
> +
> +	pattern = (unsigned char)((generation * 0x1B) ^ 0x63);
> +	for (i = 0; i < key_size; i++) {
> +		key[i] ^= pattern;
> +		pattern = (pattern << 1) | (pattern >> 7);
> +	}
> +
> +	pattern = (unsigned char)((generation * 0x2D) ^ 0x7C);
> +	for (i = 0; i < iv_size; i++) {
> +		iv[i] ^= pattern;
> +		pattern = (pattern << 1) | (pattern >> 7);
> +	}
> +
> +	for (i = 0; i < salt_size; i++)
> +		salt[i] ^= (unsigned char)(generation & 0xFF);
> +
> +	memset(rec_seq, 0, rec_seq_size);
> +}

This isn't wrong (so I'm not requesting to change it), but it seems
way overkill for "we want to fill tls12_crypto_info_aes_gcm_* with
some predictable data based only on key_generation".


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

I'm still really not convinced we need to bother with things that
would only affect a "proper" userspace.

[...]
> +static int validate_keyupdate(const char *buf, int len)
> +{
> +	if (len != 5) {
> +		printf("KeyUpdate: expected 5 bytes, got %d\n", len);
> +		return -1;
> +	}
> +
> +	if ((unsigned char)buf[0] != TLS_HANDSHAKE_KEY_UPDATE) {
> +		printf("Expected KeyUpdate (0x%02x), got 0x%02x\n",
> +		       TLS_HANDSHAKE_KEY_UPDATE, (unsigned char)buf[0]);
> +		return -1;
> +	}
> +
> +	if (buf[1] != 0 || buf[2] != 0 || buf[3] != 1) {
> +		printf("KeyUpdate: bad length field %02x%02x%02x\n",
> +		       (unsigned char)buf[1], (unsigned char)buf[2],
> +		       (unsigned char)buf[3]);
> +		return -1;
> +	}

And same here.

> +	if ((unsigned char)buf[4] != KEY_UPDATE_NOT_REQUESTED &&
> +	    (unsigned char)buf[4] != KEY_UPDATE_REQUESTED) {
> +		printf("KeyUpdate: invalid request_update value %u\n",
> +		       (unsigned char)buf[4]);
> +		return -1;
> +	}

And here.

What type of issue do you expect to identify by validating the
contents of the key update message that your test program is sending
to itself?


> +	printf("Received TLS KeyUpdate (request_update=%u)\n",
> +	       (unsigned char)buf[4]);
> +	return 0;
> +}
> +

...
> +static int do_client(void)
> +{
> +	char *buf = NULL, *echo_buf = NULL;
> +	int max_size, rekey_interval;
> +	ssize_t echo_total, echo_n;
> +	int csk = -1, ret, i, j;
> +	struct sockaddr_in sa;
> +	int test_result = -1;
> +	int current_gen = 0;
> +	int next_rekey_at;
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
> +		goto out;
> +	}
> +
> +	csk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> +	if (csk < 0) {
> +		printf("failed to create socket: %s\n", strerror(errno));

Those failures (malloc, socket, connect, maybe also initial key setup)
could use a common prefix (maybe "SETUP ERROR") to differentate them
from "invalid arguments" and "actual test failure".


[...]
> +	rekey_interval = TEST_ITERATIONS / (num_rekeys + 1);
> +	if (rekey_interval < 1)
> +		rekey_interval = 1;

nit: should never happen since num_rekeys < TEST_ITERATIONS

> +	next_rekey_at = rekey_interval;
> +
> +	for (i = 0; i < TEST_ITERATIONS; i++) {

nit: i itself is never used, only i+1, so iterating from 1 up to
i <= TEST_ITERATIONS would be a tiny bit more readable.

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

The test failures messages in the client consistently use "FAIL:" as a
prefix...

[...]
> +static int do_server(void)
> +{
[...]
> +	/* Main receive loop */
> +	while (1) {
[...]
> +			printf("recv failed: %s\n", strerror(errno));
[...]
> +				printf("Failed to send KeyUpdate\n");
[...]
> +				printf("Echo send failed: %s\n",
> +				       strerror(errno));

...but not in the server.


[...]
> +int main(int argc, char *argv[])
> +{
[...]
> +	if (tls_version == TLS_1_2_VERSION && num_rekeys) {
> +		printf("ERROR: TLS 1.2 does not support rekey\n");
> +		return -1;
> +	}

Maybe also a check to make setting random_size_max incompatible with
setting send_size. And probably at least a warning when client-only
options (server_ip, random_size, num_rekeys) are passed to the server
and will be ignored.

The "Client requires -s <ip> option" check would also fit better here,
with the rest of the options checking.



> diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
> new file mode 100755
> index 000000000000..66c5ddfd8125
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
[...]
> +def verify_tls_counters(stats_before, stats_after, expected_rekeys, is_server):

This is much cleaner now, thanks.


> +def run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=0, buffer_size=None, random_max=None):
> +    port = rand_port()
> +    send_size = random_max or buffer_size
> +
> +    server_args = f"{cfg.bin_remote} server -p {port} -c {cipher} -v {tls_version}"

These variables were called {server,client}_cmd in the previous
version, I wonder why you renamed them to something less accurate
(since it's actually the full command, not just the arguments).

> +    if send_size:
> +        server_args += f" -b {send_size}"
> +
> +    client_args = (f"{cfg.bin_local} client -s {cfg.remote_addr_v['4']} "
> +                   f"-p {port} -c {cipher} -v {tls_version}")
> +    if rekey:
> +        client_args += f" -k {rekey}"
> +    if random_max:
> +        client_args += f" -r {random_max}"
> +    elif send_size:
> +        client_args += f" -b {send_size}"

nit: I find the use of send_size here (instead of directly
buffer_size) slightly confusing, since we just took care of
"random_max was set".

-- 
Sabrina

