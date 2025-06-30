Return-Path: <netdev+bounces-202651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9C1AEE7B4
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 21:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548653A84EE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D7F2E7184;
	Mon, 30 Jun 2025 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfpqreIQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D42918DB
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312601; cv=none; b=aWgaQiLyiyUZ8voebn7AG3KfYTe2BP1PDi7mz3oyCWSn1p19PeNGeMeaILWsBNRg3/ANhfmkfaWgUGRkqlDfp9lXb+joOEee3uq/xsQNG7Pl/bfZ2wTc27a+RhgS5xrwhTDYeTXBxSMP1zUXSOZUxnkPzRy5qsUqc4JuD+DTkww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312601; c=relaxed/simple;
	bh=MUTIRF58HE/+bgQHREPX5hoQvOQERMmcmXaet+R/Tws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSvH72n6j/XDIOPobY7Rg9MOdH1PPIRwNXUHzY6NSftU6dtG/L8P8ihAxEVPnarNEe5W/+NF6iRnvhIJeHJ1t9LYivvdXBfAvCxfG5vyP6ZdjRTto3lgR2npLnx/51Dt+Ri61zWnCSgcq0j1K6YCTnm5FFqLHVO4r92DUW6YURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfpqreIQ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e447507a0so21007557b3.0
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751312599; x=1751917399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPmsUI54T51KtvuioveYX4ZHxBbVZMjRM3ICT38k9QE=;
        b=nfpqreIQjVFwiH8V3i1Hs5h8Id0jnLCFLPSUGdzjIKbxsPhcUQx4kf+ds8lf9n/aDE
         8VcqrZjpCy4G2XosRb7OqqHmZUTcGrbhtZTMAxY9645ibEgofAT66EGXO/DDtwA/hRe1
         J5FdB9ZSu0JI11Y/irkwZi5ehEmVvvLDj8de8TXUSJ3nRfZOlkGarQW8NG00fjsrIuEV
         CV0M7qNR3vMZ9GuJFq3JEmKq8o8RgYNWZO9t7vswZznl4LH63s3N60l6rCg7BQYKtkYT
         Jb/6MhzKKzLEhew3xJsOk4Qgfx8/sMBaxNkuqZ6oY3coG+IuV2shFjFebLXICffn/J/p
         9khQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751312599; x=1751917399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPmsUI54T51KtvuioveYX4ZHxBbVZMjRM3ICT38k9QE=;
        b=ZHVN/9JHTBoxQswvirOc/l9tdmuzRJVFUgcJG+AabrCFadGrM6VdWXDEvULKFKC7mq
         n3aXUyAhb2+PrYLw4clawDgol60XtuQHnhUIpWu1cAiVvx6pk1KEYH4WG3RyyqN3w8LJ
         FhA2X0IILJuDiD0A7J7CPOhHdFQwY2P+vISDVhupLXB7N3rNCCN4zoeU8oFAO2qO/Q2l
         DhI9z+uF+9q9ahm7IPis5D5mphZtkmd3Q4aHtVQP0ylKGT3rw9nesKEbBJDTZR0W2990
         tm+m6Mf0IiINLC2XOMO+tnIkDNLh2I/BtlpaJ8u6YHvYF8WUA4HJE5CxWtIFerxulqKx
         YZ7Q==
X-Gm-Message-State: AOJu0YzpK+SZdedy4Fj1tI//WIVlRtr1aMn39NFuDQJv6o6E6/JNryY6
	vEtPTNRPmrsZ0+8YVzKTICwiF5LKlSWVOftB0yADkKwV3eMBuCWn1MpaPKo2Ow==
X-Gm-Gg: ASbGnctotxhIuls4aOUBeO9I2Qjq7vapBnn8J+5GYRC2hAEWwea6LXGUu0LMTLVV14V
	wLApnh1NDsWx8CY01xh0a+jaSO1I2gscsgeQUE8LWhiseIloKU9qzcFkLesdfE3aQlgZ7yorYdU
	FaXrs5b1N9GmxjqFg0tJsJjd3jrbHq3Ca3+0pvbqhJdhv5cPXKbKlgQtk90TWT2/t9sc8srph3Y
	Rkdaeu+ToqXkqgxxYSh7T1Ov4gLzEUStkmwA9wRXxYsAsMSvMlnkEpUoPR/mq00zC9iCnfSSAsT
	OWlCEWDqQ+WWyjf11suE3t/SnQEcrhvTeKrrac99eRsLBG8UfZzmxMObLfk69XuOh93vUnVV7Pp
	ikyTqasETn/Y/MRmmfWvYyn9vuPz9yml2sjDcmsiLuzvERkDwEUXvjdgGjN0gjQ==
X-Google-Smtp-Source: AGHT+IHaxylzguMalCrZsosJkx6hq0f44cmR3YSgb1g300cOmFEfjYMG16jXwfYBFPNQ+N/IvsX1gA==
X-Received: by 2002:a05:690c:7105:b0:70f:83ef:ddff with SMTP id 00721157ae682-7151719a23emr213123687b3.30.1751312598807;
        Mon, 30 Jun 2025 12:43:18 -0700 (PDT)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb2661sm16884177b3.85.2025.06.30.12.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:43:18 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 2/2] selftest: net: extend msg_zerocopy test with forwarding
Date: Mon, 30 Jun 2025 15:42:12 -0400
Message-ID: <20250630194312.1571410-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250630194312.1571410-1-willemdebruijn.kernel@gmail.com>
References: <20250630194312.1571410-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Zerocopy skbs are converted to regular copy skbs when data is queued
to a local socket. This happens in the existing test with a sender and
receiver communicating over a veth device.

Zerocopy skbs are sent without copying if egressing a device. Verify
that this behavior is maintained even in the common container setup
where data is forwarded over a veth to the physical device.

Update msg_zerocopy.sh to

1. Have a dummy network device to simulate a physical device.
2. Have forwarding enabled between veth and dummy.
3. Add a tx-only test that sends out dummy via the forwarding path.
4. Verify the exitcode of the sender, which signals zerocopy success.

As dummy drops all packets, this cannot be a TCP connection. Test
the new case with unconnected UDP only.

Update msg_zerocopy.c to
- Accept an argument whether send with zerocopy is expected.
- Return an exitcode whether behavior matched that expectation.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/msg_zerocopy.c  | 24 +++---
 tools/testing/selftests/net/msg_zerocopy.sh | 84 +++++++++++++++------
 2 files changed, 77 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index 7ea5fb28c93d..1d5d3c4e7e87 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -77,6 +77,7 @@
 static int  cfg_cork;
 static bool cfg_cork_mixed;
 static int  cfg_cpu		= -1;		/* default: pin to last cpu */
+static int  cfg_expect_zerocopy	= -1;
 static int  cfg_family		= PF_UNSPEC;
 static int  cfg_ifindex		= 1;
 static int  cfg_payload_len;
@@ -92,9 +93,9 @@ static socklen_t cfg_alen;
 static struct sockaddr_storage cfg_dst_addr;
 static struct sockaddr_storage cfg_src_addr;
 
+static int exitcode;
 static char payload[IP_MAXPACKET];
 static long packets, bytes, completions, expected_completions;
-static int  zerocopied = -1;
 static uint32_t next_completion;
 static uint32_t sends_since_notify;
 
@@ -444,11 +445,13 @@ static bool do_recv_completion(int fd, int domain)
 	next_completion = hi + 1;
 
 	zerocopy = !(serr->ee_code & SO_EE_CODE_ZEROCOPY_COPIED);
-	if (zerocopied == -1)
-		zerocopied = zerocopy;
-	else if (zerocopied != zerocopy) {
-		fprintf(stderr, "serr: inconsistent\n");
-		zerocopied = zerocopy;
+	if (cfg_expect_zerocopy != -1 &&
+	    cfg_expect_zerocopy != zerocopy) {
+		fprintf(stderr, "serr: ee_code: %u != expected %u\n",
+			zerocopy, cfg_expect_zerocopy);
+		exitcode = 1;
+		/* suppress repeated messages */
+		cfg_expect_zerocopy = zerocopy;
 	}
 
 	if (cfg_verbose >= 2)
@@ -571,7 +574,7 @@ static void do_tx(int domain, int type, int protocol)
 
 	fprintf(stderr, "tx=%lu (%lu MB) txc=%lu zc=%c\n",
 		packets, bytes >> 20, completions,
-		zerocopied == 1 ? 'y' : 'n');
+		cfg_zerocopy && cfg_expect_zerocopy == 1 ? 'y' : 'n');
 }
 
 static int do_setup_rx(int domain, int type, int protocol)
@@ -715,7 +718,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vzZ:")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -770,6 +773,9 @@ static void parse_opts(int argc, char **argv)
 		case 'z':
 			cfg_zerocopy = true;
 			break;
+		case 'Z':
+			cfg_expect_zerocopy = !!atoi(optarg);
+			break;
 		}
 	}
 
@@ -817,5 +823,5 @@ int main(int argc, char **argv)
 	else
 		error(1, 0, "unknown cfg_test %s", cfg_test);
 
-	return 0;
+	return exitcode;
 }
diff --git a/tools/testing/selftests/net/msg_zerocopy.sh b/tools/testing/selftests/net/msg_zerocopy.sh
index 89c22f5320e0..28178a38a4e7 100755
--- a/tools/testing/selftests/net/msg_zerocopy.sh
+++ b/tools/testing/selftests/net/msg_zerocopy.sh
@@ -6,6 +6,7 @@
 set -e
 
 readonly DEV="veth0"
+readonly DUMMY_DEV="dummy0"
 readonly DEV_MTU=65535
 readonly BIN="./msg_zerocopy"
 
@@ -14,21 +15,25 @@ readonly NSPREFIX="ns-${RAND}"
 readonly NS1="${NSPREFIX}1"
 readonly NS2="${NSPREFIX}2"
 
-readonly SADDR4='192.168.1.1'
-readonly DADDR4='192.168.1.2'
-readonly SADDR6='fd::1'
-readonly DADDR6='fd::2'
+readonly LPREFIX4='192.168.1'
+readonly RPREFIX4='192.168.2'
+readonly LPREFIX6='fd'
+readonly RPREFIX6='fc'
+
 
 readonly path_sysctl_mem="net.core.optmem_max"
 
 # No arguments: automated test
 if [[ "$#" -eq "0" ]]; then
-	$0 4 tcp -t 1
-	$0 6 tcp -t 1
-	$0 4 udp -t 1
-	$0 6 udp -t 1
-	echo "OK. All tests passed"
-	exit 0
+	ret=0
+
+	$0 4 tcp -t 1 || ret=1
+	$0 6 tcp -t 1 || ret=1
+	$0 4 udp -t 1 || ret=1
+	$0 6 udp -t 1 || ret=1
+
+	[[ "$ret" == "0" ]] && echo "OK. All tests passed"
+	exit $ret
 fi
 
 # Argument parsing
@@ -45,11 +50,18 @@ readonly EXTRA_ARGS="$@"
 
 # Argument parsing: configure addresses
 if [[ "${IP}" == "4" ]]; then
-	readonly SADDR="${SADDR4}"
-	readonly DADDR="${DADDR4}"
+	readonly SADDR="${LPREFIX4}.1"
+	readonly DADDR="${LPREFIX4}.2"
+	readonly DUMMY_ADDR="${RPREFIX4}.1"
+	readonly DADDR_TXONLY="${RPREFIX4}.2"
+	readonly MASK="24"
 elif [[ "${IP}" == "6" ]]; then
-	readonly SADDR="${SADDR6}"
-	readonly DADDR="${DADDR6}"
+	readonly SADDR="${LPREFIX6}::1"
+	readonly DADDR="${LPREFIX6}::2"
+	readonly DUMMY_ADDR="${RPREFIX6}::1"
+	readonly DADDR_TXONLY="${RPREFIX6}::2"
+	readonly MASK="64"
+	readonly NODAD="nodad"
 else
 	echo "Invalid IP version ${IP}"
 	exit 1
@@ -89,33 +101,61 @@ ip netns exec "${NS2}" sysctl -w -q "${path_sysctl_mem}=1000000"
 ip link add "${DEV}" mtu "${DEV_MTU}" netns "${NS1}" type veth \
   peer name "${DEV}" mtu "${DEV_MTU}" netns "${NS2}"
 
+ip link add "${DUMMY_DEV}" mtu "${DEV_MTU}" netns "${NS2}" type dummy
+
 # Bring the devices up
 ip -netns "${NS1}" link set "${DEV}" up
 ip -netns "${NS2}" link set "${DEV}" up
+ip -netns "${NS2}" link set "${DUMMY_DEV}" up
 
 # Set fixed MAC addresses on the devices
 ip -netns "${NS1}" link set dev "${DEV}" address 02:02:02:02:02:02
 ip -netns "${NS2}" link set dev "${DEV}" address 06:06:06:06:06:06
 
 # Add fixed IP addresses to the devices
-ip -netns "${NS1}" addr add 192.168.1.1/24 dev "${DEV}"
-ip -netns "${NS2}" addr add 192.168.1.2/24 dev "${DEV}"
-ip -netns "${NS1}" addr add       fd::1/64 dev "${DEV}" nodad
-ip -netns "${NS2}" addr add       fd::2/64 dev "${DEV}" nodad
+ip -netns "${NS1}" addr add "${SADDR}/${MASK}" dev "${DEV}" ${NODAD}
+ip -netns "${NS2}" addr add "${DADDR}/${MASK}" dev "${DEV}" ${NODAD}
+ip -netns "${NS2}" addr add "${DUMMY_ADDR}/${MASK}" dev "${DUMMY_DEV}" ${NODAD}
+
+ip -netns "${NS1}" route add default via "${DADDR}" dev "${DEV}"
+ip -netns "${NS2}" route add default via "${DADDR_TXONLY}" dev "${DUMMY_DEV}"
+
+ip netns exec "${NS2}" sysctl -wq net.ipv4.ip_forward=1
+ip netns exec "${NS2}" sysctl -wq net.ipv6.conf.all.forwarding=1
 
 # Optionally disable sg or csum offload to test edge cases
 # ip netns exec "${NS1}" ethtool -K "${DEV}" sg off
 
+ret=0
+
 do_test() {
 	local readonly ARGS="$1"
 
-	echo "ipv${IP} ${TXMODE} ${ARGS}"
-	ip netns exec "${NS2}" "${BIN}" "-${IP}" -i "${DEV}" -t 2 -C 2 -S "${SADDR}" -D "${DADDR}" ${ARGS} -r "${RXMODE}" &
+	# tx-rx test
+	# packets queued to a local socket are copied,
+	# sender notification has SO_EE_CODE_ZEROCOPY_COPIED.
+
+	echo -e "\nipv${IP} ${TXMODE} ${ARGS} tx-rx\n"
+	ip netns exec "${NS2}" "${BIN}" "-${IP}" -i "${DEV}" -t 2 -C 2 \
+		-S "${SADDR}" -D "${DADDR}" ${ARGS} -r "${RXMODE}" &
 	sleep 0.2
-	ip netns exec "${NS1}" "${BIN}" "-${IP}" -i "${DEV}" -t 1 -C 3 -S "${SADDR}" -D "${DADDR}" ${ARGS} "${TXMODE}"
+	ip netns exec "${NS1}" "${BIN}" "-${IP}" -i "${DEV}" -t 1 -C 3 \
+		-S "${SADDR}" -D "${DADDR}" ${ARGS} "${TXMODE}" -Z 0 || ret=1
 	wait
+
+	# next test is unconnected tx to dummy0, cannot exercise with tcp
+	[[ "${TXMODE}" == "tcp" ]] && return
+
+	# tx-only test: send out dummy0
+	# packets leaving the host are not copied,
+	# sender notification does not have SO_EE_CODE_ZEROCOPY_COPIED.
+
+	echo -e "\nipv${IP} ${TXMODE} ${ARGS} tx-only\n"
+	ip netns exec "${NS1}" "${BIN}" "-${IP}" -i "${DEV}" -t 1 -C 3 \
+		-S "${SADDR}" -D "${DADDR_TXONLY}" ${ARGS} "${TXMODE}" -Z 1 || ret=1
 }
 
 do_test "${EXTRA_ARGS}"
 do_test "-z ${EXTRA_ARGS}"
-echo ok
+
+[[ "$ret" == "0" ]] && echo "OK"
-- 
2.50.0.727.gbf7dc18ff4-goog


