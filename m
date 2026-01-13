Return-Path: <netdev+bounces-249270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3312D166F2
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96E463015DD5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D01330FC2E;
	Tue, 13 Jan 2026 03:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ07E5TU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A7631A567
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273987; cv=none; b=PqPyJQrZvJ23dfcfCzjZOCIqAb8y/1Jc2GE35ymliyv6fJlsbJ6gcVO+6eZfInWJX03dbCaTPdHhl+mPkvnElyICGzWvir4IUm0OAtVs6NCgwpv03dkDk38+zNw0zxy4o5AI7DRd+OWYsZVl5wILPTlQgqVNZsRvH/gBF/wl0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273987; c=relaxed/simple;
	bh=uCgr9JbNpxUqM9gbGsf2Jmk4aJqJ6fTLHuKaFTvudAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZh8Wmi13ZpbQAzr4y3Dj43seYJpfg8foNFihVrKIfNCwffTTG25NXAsBouR1KskvkwhpjK4tAWZGAJOd8DGbQk/vrXKpPPT6ot6FvYdr/UT20CkuMwVIzSS3sSWDKja6JVnxKmkq1QsiYENQFA1/btxCsm/y+RcAkyNsBJbXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ07E5TU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fb6c7874cso77853247b3.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 19:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273983; x=1768878783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=jQ07E5TUF+iq7ZQq4zL4tCTN6CrcH8JW6G48bdyazJklg7S8tQMr1vP/zs7ARR1U/c
         p2VNF23O4o7+Jbyssy4a+RUOomF1LlkXOkGIVJWC/Iz2dDThJ2Vl8bQxZrxqDZv9glvw
         bG+d0U5e/sArs0hQdYGCAFLwLxt/anZo9jeqPOV4QAT2iT4PnBeDrawtXD7FsjHe/y+O
         91dZ11rtzVxaEhh5X+z8PRhcxoizPTzv9Ql3jPGakgUgU3qtTxz1T99/NuMkld/ToC49
         14wY9iGXDd3ESHYljU5LxydYYGFICXa3QpXr0YnLzc4g14Yq3MM6Zzv2Cc7p0aPpdyHG
         IZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273983; x=1768878783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=IjMvU6bGk7UbwK6Y6/begVQofPVE/MAIl7OXm21Sq/foxxz8F0wm6/FI9DO175knln
         ek/3gC2Mi7kSuj2gcv+b7WFNFoQHIAh319sXhSE8kSuVKLYB/fXTZfRTsVjXqmB7F0wA
         5TkiKI7y9X0CxrP8OeqaW0InwEf/mZUVTDopm8+qnv9Aj32DkMG4jvVPq9hiWr6339qn
         4CpGx0l4HojILWKMgTu3EpA8IIaZVC1nPV+0I1CWHiSls/wfy7lyR1xw8nF26eRUQmLE
         oLUXVheRfoIBmPPklawRjtEkQ0IhP58bGyV1OXzwr1kBgDpnRn/IenpC5IAula1myGVh
         pcFw==
X-Forwarded-Encrypted: i=1; AJvYcCVzBKhcN4J26ya7cwKxRR2H1NJeYmiMfyxSTUmA9M/UCRXW9q2oa1AWVje1CrCg2iprrcs09NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQDBLqDgsGMIhS+PLUbVLQrSBkYvmiej1fxoB0fXEW4fczanWY
	iN7cKjog0aENYgynBpCIEHQv+h0R9qE2kM8fdxL/hjYfektDx302+AyC
X-Gm-Gg: AY/fxX7DBr004SB9C1nhfszXnZgU5m/0AKcdk8Kyer64UQGY3XmrF6RBtSn/pfkCWAA
	vzUX+uASs1Am/v8zBqwRqF/nZOUgOcnG4jb6edw9m4/f0slBfDl4GdDd7qg4geGlliNs6z9lELI
	UF/YXGKbVXPJNgXpDlKPMfiZCQlvDu34e6KPATwNiDi3a1vmgNrtPRkpxgqF/3v9TEE1tiNpLxp
	ukojxQn6DP3JrOZaCZmBFW3uJI7p2BGqmDQpCCiI0EgvYfrSXqJlZLrosVD8sNn1jPO2WWzNFPg
	vrgn01d7Do2zdR6wKxOKn3vtgTMqtjqr8b/379y3GB6TGloCpGgGsZNXPy/4xr6Wqc3gSDMWXeN
	jNxhzx8OWra3qgDO6IsAu8AR8Sr1Mt6NZQFs4GOYdPF3Vo0RocrrASSWZ80H5a0IHnUGZOQ5Zjd
	jhh81wDoJW
X-Google-Smtp-Source: AGHT+IErvHvsN34Y4EeiTfc/QvQN5Cj16XfAwMvouHBrxnnMT8gw+lZ3jiDdXraGFB4o7lMM07JE3w==
X-Received: by 2002:a05:690e:1686:b0:648:f70e:2271 with SMTP id 956f58d0204a3-648f70e3129mr1251005d50.28.1768273983606;
        Mon, 12 Jan 2026 19:13:03 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7916d0c3f72sm49159977b3.21.2026.01.12.19.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:13:03 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:16 -0800
Subject: [PATCH net-next v14 07/12] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-7-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

These functions are reused by the VM tests to collect and compare dmesg
warnings and oops counts. The future VM-specific tests use them heavily.
This patches relies on vm_ssh() already supporting namespaces.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- break these out into an earlier patch so that they can be used
  directly in new patches (instead of causing churn by adding this
  later)
---
 tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 1d03acb62347..4b5929ffc9eb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -380,6 +380,17 @@ host_wait_for_listener() {
 	fi
 }
 
+vm_dmesg_oops_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops'
+}
+
+vm_dmesg_warn_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
+}
 
 vm_vsock_test() {
 	local ns=$1
@@ -587,8 +598,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -606,13 +617,13 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3


