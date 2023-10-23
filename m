Return-Path: <netdev+bounces-43434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD4E7D30BE
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 13:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A741C20912
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3413ADC;
	Mon, 23 Oct 2023 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kHiolWls"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1011845;
	Mon, 23 Oct 2023 11:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E98CC433C8;
	Mon, 23 Oct 2023 11:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698058901;
	bh=ROMldOO2F834+uhJRiaeC7qSa3qhpJpnAu3YDajkvvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHiolWlseJ1h+6MsHQ2jzY0OnRALvYrvfVPhvqd9GWj1DaZzqRScMopKjAcIF6IuX
	 UfAmbg3aSfh6p0fGntF5T2RuP+e6Lzgv3rpKjSmuzwAs1c6u9nifoww5hYp9DnbvnA
	 LFH77btoVRiDQ9Hy+CZOm/lA3qcrHUAtoqrZzpPI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Edward AD <twuufnxlz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.14 65/66] Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX name
Date: Mon, 23 Oct 2023 12:56:55 +0200
Message-ID: <20231023104813.233084143@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104810.781270702@linuxfoundation.org>
References: <20231023104810.781270702@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit cb3871b1cd135a6662b732fbc6b3db4afcdb4a64 upstream.

The code pattern of memcpy(dst, src, strlen(src)) is almost always
wrong. In this case it is wrong because it leaves memory uninitialized
if it is less than sizeof(ni->name), and overflows ni->name when longer.

Normally strtomem_pad() could be used here, but since ni->name is a
trailing array in struct hci_mon_new_index, compilers that don't support
-fstrict-flex-arrays=3 can't tell how large this array is via
__builtin_object_size(). Instead, open-code the helper and use sizeof()
since it will work correctly.

Additionally mark ni->name as __nonstring since it appears to not be a
%NUL terminated C string.

Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Edward AD <twuufnxlz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Fixes: 18f547f3fc07 ("Bluetooth: hci_sock: fix slab oob read in create_monitor_event")
Link: https://lore.kernel.org/lkml/202310110908.F2639D3276@keescook/
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_sock.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -425,7 +425,8 @@ static struct sk_buff *create_monitor_ev
 		ni->type = hdev->dev_type;
 		ni->bus = hdev->bus;
 		bacpy(&ni->bdaddr, &hdev->bdaddr);
-		memcpy(ni->name, hdev->name, strlen(hdev->name));
+		memcpy_and_pad(ni->name, sizeof(ni->name), hdev->name,
+			       strnlen(hdev->name, sizeof(ni->name)), '\0');
 
 		opcode = cpu_to_le16(HCI_MON_NEW_INDEX);
 		break;



