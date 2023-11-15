Return-Path: <netdev+bounces-47916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFC07EBE69
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34216281121
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 08:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8224687;
	Wed, 15 Nov 2023 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="0n9RP+/J"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D349441A;
	Wed, 15 Nov 2023 08:15:14 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12ED2DF;
	Wed, 15 Nov 2023 00:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:Message-ID:Date:MIME-Version:
	User-Agent:To:Cc:From:Subject:Content-Type:
	Content-Transfer-Encoding; bh=x9WiF2WJJg4nuq9y2/iHdxmnQgPVT3zWXn
	xves3ORlo=; b=0n9RP+/JfX/DqCIz/LuBypmsdyups/yvFNGD6fwE2vuaHzS4Yo
	87R7Yo9E4SZlLxysFNWM96Gt+Mv5EsfBx5vG25dKnYpZZB/Nsy9VvaIRTqQIVQS1
	y9JEsylf9AXvixrj1ob4utyRxwg/j41V8cNjpyOcEAM7lFFcEVw+RbL+A=
Received: from [10.192.52.248] (unknown [10.192.52.248])
	by coremail-app1 (Coremail) with SMTP id OCz+CgCHuFoAflRl43kdAA--.30248S2;
	Wed, 15 Nov 2023 16:14:56 +0800 (CST)
Message-ID: <780d3461-a920-4f44-8d32-06bcb3988cea@buaa.edu.cn>
Date: Wed, 15 Nov 2023 16:14:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: baijiaju1990@gmail.com, 20373622@buaa.edu.cn, zhenghaoran@buaa.edu.cn,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
From: Si-Jie Bai <sy2239101@buaa.edu.cn>
Subject: [BUG]Bluetooth: possible semantic bug when HCI_Command_Status event
 triggered without prior HCI_Inquiry command
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:OCz+CgCHuFoAflRl43kdAA--.30248S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1fKryfuw4UtFW3WF47CFg_yoW8tFyDpa
	yFkFsIgrWkJF93Wr17Ja18Zay8Jw1vvrWDKr12v34rtwsxJFWvkF4jk34jqayUXrWvyrnY
	v3W0vF13tFyDCa7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBlb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1ln4kS14v26r1Y6r17M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz4
	8v1sIEY20_Aw1UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8DCztUUUUU==
X-CM-SenderInfo: tv1sjjizrqiqpexdthxhgxhubq/

Hello,

Our fuzzing tool finds a possible semantic bug in the Bluetooth system 
in Linux 6.2:

According to the core specification v5.4, the HCI_Inquiry command 
triggers the BR/EDR Controller to enter Inquiry Mode, a process used for 
discovering nearby BR/EDR Controllers. Furthermore, it is specified that 
an HCI_Command_Status event should be sent to the Host when the BR/EDR 
Controller has started the Inquiry process.

In our testing, if a related HCI_Command_Status event is sent by the 
controller without a preceding HCI_Inquiry command from the host, this 
could lead to a failure in establishing Bluetooth connections.

Through our examination and debugging of the Linux 6.2 source code, we 
have identified the underlying cause of the observed phenomenon:

(1.1) When the HCI_Command_Status event related to the HCI_Inquiry 
command is received, the function hci_cs_inquiry 
(/net/bluetooth/hci_event.c:2289) is called.

(1.2) This leads to the execution of set_bit(HCI_INQUIRY, &hdev->flags); 
(/net/bluetooth/hci_event.c:2298).

(2.1) Upon initiating an ACL connection for the first time, the function 
hci_acl_create_connection (/net/bluetooth/hci_conn.c:212) is called.

(2.2) The result of test_bit(HCI_INQUIRY, &hdev->flags) 
(/net/bluetooth/hci_conn.c:228) being true causes the connection's state 
to change to BT_CONNECT2, and the HCI_Inquiry_Cancel command is sent.

(3.1) When the HCI_Command_Complete event related to the 
HCI_Inquiry_Cancel command is received, the function 
hci_cc_inquiry_cancel (/net/bluetooth/hci_event.c:84) is called.

(3.2) The Status field of the HCI_Command_Complete event being 0x0c 
results in the execution of return rp->status; 
(/net/bluetooth/hci_event.c:104).

(4.1) A timeout triggers hci_conn_timeout 
(/net/bluetooth/hci_conn.c:638), which in turn calls hci_abort_conn 
(/net/bluetooth/hci_conn.c:2771).

(4.2) This leads to the execution of case BT_CONNECT2: 
(/net/bluetooth/hci_conn.c:2771), where the 
HCI_Reject_Connection_Request command is sent.

We are not sure whether this is a semantic bug or implementation feature 
in the Linux kernel. Any feedback would be appreciated, thanks!

Best wishes,
Sijie Bai


