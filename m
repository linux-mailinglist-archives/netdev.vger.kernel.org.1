Return-Path: <netdev+bounces-152477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC50E9F4115
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 03:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F45E1888641
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EF22BCF5;
	Tue, 17 Dec 2024 02:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IOK8g4Xr"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4AB8F49;
	Tue, 17 Dec 2024 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734403761; cv=none; b=i2/FK1zwofYxMcFdGEjNemVAEKkDe2XAHQ5gloyvxlcGkxi6PP2eYmcBXUhSh4YfdS/MB9UKKWzQSh1bDf4LlLd01csulqWwF18+dcaVQUSi9icDTx1YEUGYQWKo8rwS5soz6XtS+sFfq7lpkYbny1afwBayIaTahR68hLnlVcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734403761; c=relaxed/simple;
	bh=N+CAVsbpIYPHu7HUrguI9Omgy2/k3xK231nE65VOba8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gb0PUTzNzY7YPAHdSpDwFVpTThcRRv2LSepRcuoFqGxE47L5Z2GyAb+RmXi8m9kuxS2JChGCQCbfb1CQoUZSCLlKBaIC/YNKBvXnXtTpTJejP//9XYrpuiJQl0oV/d7PKsWPC2MYP+1zccPnJcBb0ctMTkyvAeF/fIfbCASulSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IOK8g4Xr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGMPwlo012810;
	Tue, 17 Dec 2024 02:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+kmBSYiCls72GF9h2ZxMxrU1WuXbRanYZktfT1B8PVM=; b=IOK8g4Xrwb2TfDLq
	Ka0n09KsBecIjETtDP0uw98/XmSfNkgoZW8n5Nd03HNV0maCg4Cs1ivXbzZvBMJl
	3ED7jjdYUKsysCgl0xF99bt8CfGyiUQEfw30A0doJ4yg4fxlGfFaWQCSvfq8muod
	PagHd1vwalzfbi7+79S5XJzoVBneGjV6PbLj0RujJwpP/kstwVkqIEO2xK4rE0Wi
	VUDUqBUdFctg9VLgQ95m2j8Pnn3woMaK0qR+egRo2oFxmy5tqvifykkCmzrFy2JC
	4kWjueDv6Nf0kGiG0CR+lDlzB1XM3+jffZ2kZ0vGCbrlIZpJOEdNwAELFQZkotzV
	E1d4Jw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jw068g1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 02:49:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH2n7lk013730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 02:49:07 GMT
Received: from [10.231.216.175] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Dec
 2024 18:49:03 -0800
Message-ID: <bb9505d6-e8ae-47dc-a1e0-6d1974dc12ac@quicinc.com>
Date: Tue, 17 Dec 2024 10:49:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix disconnect complete event
 timeout issue
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg
	<johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_jiaymao@quicinc.com>, <quic_shuaz@quicinc.com>,
        <quic_zijuhu@quicinc.com>, <quic_mohamull@quicinc.com>
References: <20241216080758.3450976-1-quic_chejiang@quicinc.com>
 <CABBYNZLRdu_f9eNEapPp5mNqgcUE0jby5VPpaMaArY_FjyjB8Q@mail.gmail.com>
 <CABBYNZKPu20vHx3DMGXVobR_5t-WUgt-KX41+tA1Lrz+aDFY-Q@mail.gmail.com>
Content-Language: en-US
From: "Cheng Jiang (IOE)" <quic_chejiang@quicinc.com>
In-Reply-To: <CABBYNZKPu20vHx3DMGXVobR_5t-WUgt-KX41+tA1Lrz+aDFY-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A69n2jaco9aUUJ0wsutu1Jxcu-yf85O4
X-Proofpoint-GUID: A69n2jaco9aUUJ0wsutu1Jxcu-yf85O4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170021

Hi Luiz,

On 12/16/2024 10:42 PM, Luiz Augusto von Dentz wrote:
> Hi Cheng,
> 
> On Mon, Dec 16, 2024 at 9:32 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Cheng,
>>
>> On Mon, Dec 16, 2024 at 3:08 AM Cheng Jiang <quic_chejiang@quicinc.com> wrote:
>>>
>>> Sometimes, the remote device doesn't acknowledge the LL_TERMINATE_IND
>>> in time, requiring the controller to wait for the supervision timeout,
>>> which may exceed 2 seconds. In the current implementation, the
>>> HCI_EV_DISCONN_COMPLETE event is ignored if it arrives late, since
>>> the hci_abort_conn_sync has cleaned up the connection after 2 seconds.
>>> This causes the mgmt to get stuck, resulting in bluetoothd waiting
>>> indefinitely for the mgmt response to the disconnect. To recover,
>>> restarting bluetoothd is necessary.
>>>
>>> bluetoothctl log like this:
>>> [Designer Mouse]# disconnect D9:B5:6C:F2:51:91
>>> Attempting to disconnect from D9:B5:6C:F2:51:91
>>> [Designer Mouse]#
>>> [Designer Mouse]# power off
>>> [Designer Mouse]#
>>> Failed to set power off: org.freedesktop.DBus.Error.NoReply.
>>>
>>> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
>>> ---
>>>  include/net/bluetooth/hci_core.h |  2 ++
>>>  net/bluetooth/hci_conn.c         |  9 +++++++++
>>>  net/bluetooth/hci_event.c        |  9 +++++++++
>>>  net/bluetooth/hci_sync.c         | 18 ++++++++++++++++++
>>>  4 files changed, 38 insertions(+)
>>>
>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>> index 734cd50cd..2ab079dcf 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -753,6 +753,8 @@ struct hci_conn {
>>>
>>>         struct bt_codec codec;
>>>
>>> +       struct completion disc_ev_comp;
>>> +
>>>         void (*connect_cfm_cb)  (struct hci_conn *conn, u8 status);
>>>         void (*security_cfm_cb) (struct hci_conn *conn, u8 status);
>>>         void (*disconn_cfm_cb)  (struct hci_conn *conn, u8 reason);
>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>>> index d097e308a..e0244e191 100644
>>> --- a/net/bluetooth/hci_conn.c
>>> +++ b/net/bluetooth/hci_conn.c
>>> @@ -1028,6 +1028,15 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
>>>
>>>         hci_conn_init_sysfs(conn);
>>>
>>> +       /* This disc_ev_comp is inited when we send a disconnect request to
>>> +        * the remote device but fail to receive the disconnect complete
>>> +        * event within the expected time (2 seconds). This occurs because
>>> +        * the remote device doesn't ack the terminate indication, forcing
>>> +        * the controller to wait for the supervision timeout.
>>> +        */
>>> +       init_completion(&conn->disc_ev_comp);
>>> +       complete(&conn->disc_ev_comp);
>>> +
>>>         return conn;
>>>  }
>>>
>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>>> index 2cc7a9306..60ecb2b18 100644
>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -3366,6 +3366,15 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
>>>         if (!conn)
>>>                 goto unlock;
>>>
>>> +       /* Wake up disc_ev_comp here is ok. Since we hold the hdev lock
>>> +        * hci_abort_conn_sync will wait hdev lock release to continue.
>>> +        */
>>> +       if (!completion_done(&conn->disc_ev_comp)) {
>>> +               complete(&conn->disc_ev_comp);
>>> +               /* Add some delay for hci_abort_conn_sync to handle the complete */
>>> +               usleep_range(100, 1000);
>>> +       }
>>> +
>>>         if (ev->status) {
>>>                 mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
>>>                                        conn->dst_type, ev->status);
>>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>>> index 0badec712..783d04b57 100644
>>> --- a/net/bluetooth/hci_sync.c
>>> +++ b/net/bluetooth/hci_sync.c
>>> @@ -5590,6 +5590,24 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
>>>                 break;
>>>         }
>>>
>>> +       /* Check whether the connection is successfully disconnected.
>>> +        * Sometimes the remote device doesn't acknowledge the
>>> +        * LL_TERMINATE_IND in time, requiring the controller to wait
>>> +        * for the supervision timeout, which may exceed 2 seconds. In
>>> +        * this case, we need to wait for the HCI_EV_DISCONN_COMPLETE
>>> +        * event before cleaning up the connection.
>>> +        */
>>> +       if (err == -ETIMEDOUT) {
>>> +               u32 idle_delay = msecs_to_jiffies(10 * conn->le_supv_timeout);
>>> +
>>> +               reinit_completion(&conn->disc_ev_comp);
>>> +               if (!wait_for_completion_timeout(&conn->disc_ev_comp, idle_delay)) {
>>> +                       bt_dev_warn(hdev, "Failed to get complete");
>>> +                       mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
>>> +                                              conn->dst_type, conn->abort_reason);
>>> +               }
>>> +       }
>>
>> Why don't we just set the supervision timeout as timeout then? If we
>> will have to wait for it anyway just change hci_disconnect_sync to use
>> 10 * conn->le_supv_timeout as timeout instead.
>>
hci_disconnect_sync uses __hci_cmd_sync_status_sk to wait for the 
HCI_EV_DISCONN_COMPLETE event, which will send the command in hci_cmd_work. 
In hci_cmd_work, it will start a timer with HCI_CMD_TIMEOUT(2s) to wait 
for the event. So even in hci_disconnect_sync we can set the timeout to
supervision timeout, hci_disconnect_sync still timeout after 2s. 

>> That said, we really need to fix bluetoothd if it is not able to be
>> cleaned up if SET_POWERED command fails, but it looks like it is
>> handling errors correctly so it sounds like something else is at play.
> 
The issue arises after a 2-second timeout of hci_disconnect_sync. During 
hci_abort_conn_sync, the connection is cleaned up by hci_conn_failed. 
after supervision timeout, the disconnect complete event arrives, but 
it returns at line 3370 since the connection has already been removed. 
As a result, bluetoothd does not send the mgmt event for MGMT_OP_DISCONNECT 
to the application layer (bluetoothctl), causing bluetoothctl to get stuck 
and unable to perform other mgmt commands.


3355 static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
3356              struct sk_buff *skb)
3357 {
3358   struct hci_ev_disconn_complete *ev = data;
3359   u8 reason;
3360   struct hci_conn_params *params;
3361   struct hci_conn *conn;
3362   bool mgmt_connected;
3363
3364   bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
3365
3366   hci_dev_lock(hdev);
3367
3368   conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
3369   if (!conn)
3370     goto unlock;
3371
3372   if (ev->status) {
3373     mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
3374                conn->dst_type, ev->status);
3375     goto unlock;
3376   }
3377
3378   conn->state = BT_CLOSED;
3379
3380   mgmt_connected = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
3381

> I double checked this and apparently this could no longer fail:
> 
> +               /* Disregard possible errors since hci_conn_del shall have been
> +                * called even in case of errors had occurred since it would
> +                * then cause hci_conn_failed to be called which calls
> +                * hci_conn_del internally.
> +                */
> +               hci_abort_conn_sync(hdev, conn, reason);
> 
> So it will clean up the hci_conn no matter what is the timeout, so
> either you don't have this change or it is not working for some
> reason.
> 
The issue is mgmt command is not repsonsed by bluetoothd, then the bluetootlctl is 
blocked. It does not happen during the power off stage. It happened when disconnect 
a BLE device, but the disconnect complete event sent from controller to host 2s later.
Then it causes the mgmt in bluetoothctl is blocked as decribed as above. 

>>>         hci_dev_lock(hdev);
>>>
>>>         /* Check if the connection has been cleaned up concurrently */
>>>
>>> base-commit: e25c8d66f6786300b680866c0e0139981273feba
>>> --
>>> 2.34.1
>>>
>>
>>
>> --
>> Luiz Augusto von Dentz
> 
> 
> 


