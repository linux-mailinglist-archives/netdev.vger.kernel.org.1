Return-Path: <netdev+bounces-238133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D87A2C54850
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C33584E0757
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8862D321A;
	Wed, 12 Nov 2025 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RHcBjt1h"
X-Original-To: netdev@vger.kernel.org
Received: from sonic314-20.consmr.mail.gq1.yahoo.com (sonic314-20.consmr.mail.gq1.yahoo.com [98.137.69.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF81C84BC
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980807; cv=none; b=OYsCZ03E4ll6qL8n1tF2ODYbal1gldp+LrM3wC5zhy22fey0VDnI2NIlWuwQKW/fHvxg9yPMjokX9H7Ipq/m6bpaOPq//p/jUMbHaKVh0yCSPwQvnKAxDmnUgOFA4tplKo9oY4qwemZM2MJy0ai9XszyPiVlAnEpfJeArUZoH7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980807; c=relaxed/simple;
	bh=vbjveGnYMXTuJI584eq5Mmx1IGg/Oz6qYfjKt7XJDC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TY4EWQ0CzFVDaZ5McGtudfcp/5useVZk70UhSN5Zuaa75L4xmmM6v6zZQJE7/bH/h4TwVZb97UIrRfEVZqUuq/CJ8TLNRpPFpykffdOpQ8sAblidkKlnx9TKRPLmhaiSeowLylkH6QQy4ayp+DnOCxni5rBI3TUEfjIOUIl/0NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=RHcBjt1h; arc=none smtp.client-ip=98.137.69.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762980804; bh=P+mgKgRVnjTCMkTyxs/dwOiEN3OTY5NOVUCeAub0SnQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=RHcBjt1huTJcRHxgFwoj5HSWdcuwPvWW7rvnxlMGy4IDx56vYVmAUh9BbNWSJKt5hGvXpwyYpe+ASKvFWids//Kw6E5zP0pt+7od2cM4QErSIvh4fBA0Id87+GJBISrqlM3gOH9dN7oD6lGk/ax75VVhkL2nQPPi3bZF1D2FdgHlteK5GP33zdHobHGc1mtI/WP7ohq5rJKycYVxTwQgaKOcPghPVYZwl6w2TpIpbBCSYk5A7KLmNnXl68qtbXtzc3ZbzgCxIMp8hlZc1PtOFK8p8webxchXCqFOTpbCAL6fG/aGPZQ71i5ikNSf4uK4pS+LqPLvBTxL1tEbEl/72A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762980804; bh=jKWybfNNyWh+fJSgcyWLu73tvCABmNUMelGOmAb/DSk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WTCn+Pt5sh2HJfzX0OCtWFehXUfWc/OV7HJBBJ8/U8fhQ4XQG570zQlLp/4QNUhXk/ncaxoy3zJDUKSeT/ftqMXMD1F9OHBRrONf/7sDzIX179NH9tVMjzn2nDyB9FAuhbOprPzUEYLtxbjzsR2bvKJ45av6CWd4i9tbQckhi5UgMo+06t0Q6KukFEpREIRM/2M4DpSZUAz6GZfXKhoC4MvRtKgfJ1o0FSk77mko6hgA3epE6TcYfhII+OIN9JbVakacb+3IVmuhWkfhc7478a81/4bgfogO4uexl5n9raQDMozJ9FAGIU+I+4D3FxCi0IUMP49iP6ftQ/+ey0YJ5g==
X-YMail-OSG: gNpfY9wVM1ktoJK2qIt5Qzu8GFZ81CYhAtDKCJLIL08zenC.EK6Y7c.b8pfoWuu
 zSgaiRBX_.._XAiWhbhFu6_SJee7.ZdvYB6kcHjhwqtNsChW4B8SiXsV9mhRvJzlKSldPZqCr05G
 _pNs7sVyva7IiBxQiemvTad6iIG87.wqI8dNEj45rtRY8YiIm9DStJ9tZmfMI2mBlV9AwvdST1Bv
 YwBcLX4Xj0_2N4.Mze2GhguOa.a5OdJurQIAAXOelP.AMfNZmkait84SovZj.CzCc7ws0ykIa4EI
 SAxuYnXdD7kPdF83A0GVzKmhVKGp7jE0gF5ZR7S6xcNSSQHbAPmWjBPsvYylWr00rp4rsBwAONv8
 3QYzk1IfX_dAfPO__VfG6hT_gDd6EIk8RCZb8JCswpsXkGbfgYzC2RG45VWEzFItX6zzTv_X4U_R
 kuKGU5fLXH281b7_fx87CLJZrL2.k2TTfqLutEQ4Gjc0MLaD1EzeZKLk8YHNrnYxrc1iW3llHB1h
 JlaYT9EoHAXMTLF120iNFx5mMt84peXSWExT5EtWnjJRHfa.oIVHVp5aFN6YCJtSXg_i3hns5gT3
 RlXo_jJRYcV1kFoWtDR0s_XJPwYIfMBEqS82k1ed83WPoBcVndkEB6Ev1EK.uiQIE0j1qaFYnHBr
 6lfn9GvcNTtUX5tmr.hYXBeNRQHgwqJg2z8YQS.FKWnQ0SfxAiw7z3IJZPAGMyJJFZogNGOkGV8b
 iGfx3m2aSZHh86SebLSoN8rhaHoiTt_GCPmqla27oPQZyvzm8WxU.x2loHDb0XoP3hpQETTtmbpX
 4oRqNhoYZYs0uyXwIz1toar7PtZF15Ha7JvSKaIvqgWZwNA.Z9JTScXI_JqYa7R9ZB3NDb8GXD_M
 0CdjJxwKuhqHvL7zK.6Tsn0TMifHUE9r9OxCVgI8sUTbx_PEC0XfrsuGrrDO0f99.3wQc5PTXRlO
 69SiN25AgNO1k4PkDZ0vhG_6n4w7cAjOgkbegA60BcbpGYq6D9MqfGjQv.gEMZz2WSNFQrPpGUpD
 _0Eq3cTeLO2Yt0eIUc2dCXBwLVeIO.hDBJ_OIBTpheQmCVT61ffJAfkMub0qiRvoR.K7BFa8nIKB
 3ZP8xelqhhp2TVRM3UeYYh3YF6KggvebmKZ_JzOnvbCxWyGA75e84QXbv_qSnmoh1w2352b3ZYMI
 OdwYqhzwxvpCkk8yuuOQfqP7DtF2GSRuzIXaiAEyzs6X75Gof7DfqY_3Dgc_TUAypArktilThyRb
 O8Yh3GRxhJYVouQmKzBPiCJ1s1eV7qEmc_Gh62kGmNx9sl9DEzgc1PhP_4vP6S404H8h4fbuy8bj
 bmJ99aX_2XjlwlW7EDiaTRm_otAGQDsEn0q9qDqWzE_C.lYzcHp6.CyDzrc_Mw7cNQUpFh9Rv4kM
 lLjoRrgoyPg_6SZX5WUYdK6Tg5DMv9BrnM1v3NcoWTFB1FZT.kQ73gUCAg1Bya8FylKJQwo0CFrt
 .weOURsgMUEtVTuJFN5iB1_GDpwUB1vXJ2FaC2.l_9lPORJEUpexdnVDA2YOHRA4cPHnTxQeTOCD
 SantbgoZ.5TvAzkagM8v8xxo4jBAknCVv2HI60o7zAp0E5BikprNYIYWXS2N.cAR4W8B2nRKyWa1
 XS4.cZ.EfiSFhA.4SVTOSrQ_Ix1mW6IcNQ9HlJJVFFC7sqkEnusZzu8nIJDIJNzMSVJkKM0CRQWj
 Rt4Exu0r72INZtSd1_Mm7pWloNfEbz92YEukQQ45oqjghi2Xb2O3.6VlvuzdwcUQLVEZyfhJrxj7
 q1C0JQ8C3A2HaY7I7cqqGUJcbjPqM.XGP7u8ge5GmPMgetv0W4kH2XwhKnc_ngjEnWpJWaFtwwX6
 tXeWvOk_GXGU5zBwvX7BXhbxhAs75BAEtk2WH5ukpPHxbvnSMVXQK2deWfU9VMJ4uYTpSey4txUg
 J80nlWFKL_c3fTV8cYGX5mxd7Md6U7bfxCDwA9uaBjbQpQYIxbVbgHXZhmsyL_aiSNq6I.VpWPVZ
 .vFMNP4jBOFWY5UV7PKZzo_rR6pwgvtaAro2EjOY4JBKaQGxym5cMDy8i2pPttOVURwEoXqRrpmP
 pbZajRJTGNc5Ta4TTYe9YI5XseGcuECYvw5sdbBhR11pCk1HP_.E0Q1C4zoMDK.lhI4FD2xqksNU
 x7myG8l41boNifkPeU3ViRdPFd8pu.qQyda28v9Hejw0S2.hD78cC2BmxKNWkT1FiWcJxRxdUDE8
 TLom09YpFoT1y8Qcr6MBuZFlESdhQlqeE5HuJS.qe.2eH_Or8DrXy3RYK.TApp14.avbPfpUnDRq
 1hYgQxV88k5Mj0Q--
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: c87ebaf7-7d76-477a-a4b8-3d93967514a8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Wed, 12 Nov 2025 20:53:24 +0000
Received: by hermes--production-bf1-58477f5468-mv22l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID aa11b75316de3424f98b7bca4e22d9d5;
          Wed, 12 Nov 2025 20:33:07 +0000 (UTC)
Message-ID: <3c01e222-8e58-46ce-9ce7-b536bfb11028@yahoo.com>
Date: Wed, 12 Nov 2025 21:32:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: af_unix: Add tests for ECONNRESET and EOF
 semantics
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, david.hunter.linux@gmail.com, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org,
 skhan@linuxfoundation.org
References: <26835ada-4e3a-4f78-8705-4ed2e3d44bd8@yahoo.com>
 <20251107070711.2369272-1-kuniyu@google.com>
Content-Language: en-US
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251107070711.2369272-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/7/25 08:05, Kuniyuki Iwashima wrote:
> From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> Date: Tue, 4 Nov 2025 11:42:47 +0100
>> On 11/4/25 01:30, Kuniyuki Iwashima wrote:
>>> On Mon, Nov 3, 2025 at 4:08 PM Sunday Adelodun
>>> <adelodunolaoluwa@yahoo.com> wrote:
>>>> On 11/2/25 08:32, Kuniyuki Iwashima wrote:
>>>>> On Sat, Nov 1, 2025 at 10:23 AM Sunday Adelodun
>>>>> <adelodunolaoluwa@yahoo.com> wrote:
>>>>>> Add selftests to verify and document Linux’s intended behaviour for
>>>>>> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
>>>>>> The tests verify that:
>>>>>>
>>>>>>     1. SOCK_STREAM returns EOF when the peer closes normally.
>>>>>>     2. SOCK_STREAM returns ECONNRESET if the peer closes with unread data.
>>>>>>     3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>>>>>>     4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data.
>>>>>>     5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
>>>>>>
>>>>>> This follows up on review feedback suggesting a selftest to clarify
>>>>>> Linux’s semantics.
>>>>>>
>>>>>> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
>>>>>> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
>>>>>> ---
>>>>>>     tools/testing/selftests/net/af_unix/Makefile  |   1 +
>>>>>>     .../selftests/net/af_unix/unix_connreset.c    | 179 ++++++++++++++++++
>>>>>>     2 files changed, 180 insertions(+)
>>>>>>     create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c
>>>>>>
>>>>>> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
>>>>>> index de805cbbdf69..5826a8372451 100644
>>>>>> --- a/tools/testing/selftests/net/af_unix/Makefile
>>>>>> +++ b/tools/testing/selftests/net/af_unix/Makefile
>>>>>> @@ -7,6 +7,7 @@ TEST_GEN_PROGS := \
>>>>>>            scm_pidfd \
>>>>>>            scm_rights \
>>>>>>            unix_connect \
>>>>>> +       unix_connreset \
>>>>> patchwork caught this test is not added to .gitignore.
>>>>> https://patchwork.kernel.org/project/netdevbpf/patch/20251101172230.10179-1-adelodunolaoluwa@yahoo.com/
>>>>>
>>>>> Could you add it to this file ?
>>>>>
>>>>> tools/testing/selftests/net/.gitignore
>>>> Oh, thank you for this. will add it
>>>>>>     # end of TEST_GEN_PROGS
>>>>>>
>>>>>>     include ../../lib.mk
>>>>>> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools/testing/selftests/net/af_unix/unix_connreset.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..6f43435d96e2
>>>>>> --- /dev/null
>>>>>> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
>>>>>> @@ -0,0 +1,179 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +/*
>>>>>> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
>>>>>> + *
>>>>>> + * This test verifies:
>>>>>> + *  1. SOCK_STREAM returns EOF when the peer closes normally.
>>>>>> + *  2. SOCK_STREAM returns ECONNRESET if peer closes with unread data.
>>>>>> + *  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>>>>>> + *  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data.
>>>>>> + *  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
>>>>>> + *
>>>>>> + * These tests document the intended Linux behaviour.
>>>>>> + *
>>>>>> + */
>>>>>> +
>>>>>> +#define _GNU_SOURCE
>>>>>> +#include <stdlib.h>
>>>>>> +#include <string.h>
>>>>>> +#include <fcntl.h>
>>>>>> +#include <unistd.h>
>>>>>> +#include <errno.h>
>>>>>> +#include <sys/socket.h>
>>>>>> +#include <sys/un.h>
>>>>>> +#include "../../kselftest_harness.h"
>>>>>> +
>>>>>> +#define SOCK_PATH "/tmp/af_unix_connreset.sock"
>>>>>> +
>>>>>> +static void remove_socket_file(void)
>>>>>> +{
>>>>>> +       unlink(SOCK_PATH);
>>>>>> +}
>>>>>> +
>>>>>> +FIXTURE(unix_sock)
>>>>>> +{
>>>>>> +       int server;
>>>>>> +       int client;
>>>>>> +       int child;
>>>>>> +};
>>>>>> +
>>>>>> +FIXTURE_VARIANT(unix_sock)
>>>>>> +{
>>>>>> +       int socket_type;
>>>>>> +       const char *name;
>>>>>> +};
>>>>>> +
>>>>>> +/* Define variants: stream and datagram */
>>>>> nit: outdated, maybe simply remove ?
>>>> oh..skipped me.
>>>> will do so.
>>>>>> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
>>>>>> +       .socket_type = SOCK_STREAM,
>>>>>> +       .name = "SOCK_STREAM",
>>>>>> +};
>>>>>> +
>>>>>> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
>>>>>> +       .socket_type = SOCK_DGRAM,
>>>>>> +       .name = "SOCK_DGRAM",
>>>>>> +};
>>>>>> +
>>>>>> +FIXTURE_VARIANT_ADD(unix_sock, seqpacket) {
>>>>>> +       .socket_type = SOCK_SEQPACKET,
>>>>>> +       .name = "SOCK_SEQPACKET",
>>>>>> +};
>>>>>> +
>>>>>> +FIXTURE_SETUP(unix_sock)
>>>>>> +{
>>>>>> +       struct sockaddr_un addr = {};
>>>>>> +       int err;
>>>>>> +
>>>>>> +       addr.sun_family = AF_UNIX;
>>>>>> +       strcpy(addr.sun_path, SOCK_PATH);
>>>>>> +       remove_socket_file();
>>>>>> +
>>>>>> +       self->server = socket(AF_UNIX, variant->socket_type, 0);
>>>>>> +       ASSERT_LT(-1, self->server);
>>>>>> +
>>>>>> +       err = bind(self->server, (struct sockaddr *)&addr, sizeof(addr));
>>>>>> +       ASSERT_EQ(0, err);
>>>>>> +
>>>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>>>> +               variant->socket_type == SOCK_SEQPACKET) {
>>>>> patchwork caught mis-alignment here and other places.
>>>>>
>>>>> I'm using this for emacs, and other editors will have a similar config.
>>>>>
>>>>> (setq-default c-default-style "linux")
>>>>>
>>>>> You can check if lines are aligned properly by
>>>>>
>>>>> $ git show --format=email | ./scripts/checkpatch.pl
>>>>>
>>>>>
>>>>>> +               err = listen(self->server, 1);
>>>>>> +               ASSERT_EQ(0, err);
>>>>>> +
>>>>>> +               self->client = socket(AF_UNIX, variant->socket_type, 0);
>>>>> Could you add SOCK_NONBLOCK here too ?
>>>> This is noted
>>>>>> +               ASSERT_LT(-1, self->client);
>>>>>> +
>>>>>> +               err = connect(self->client, (struct sockaddr *)&addr, sizeof(addr));
>>>>>> +               ASSERT_EQ(0, err);
>>>>>> +
>>>>>> +               self->child = accept(self->server, NULL, NULL);
>>>>>> +               ASSERT_LT(-1, self->child);
>>>>>> +       } else {
>>>>>> +               /* Datagram: bind and connect only */
>>>>>> +               self->client = socket(AF_UNIX, SOCK_DGRAM | SOCK_NONBLOCK, 0);
>>>>>> +               ASSERT_LT(-1, self->client);
>>>>>> +
>>>>>> +               err = connect(self->client, (struct sockaddr *)&addr, sizeof(addr));
>>>>>> +               ASSERT_EQ(0, err);
>>>>>> +       }
>>>>>> +}
>>>>>> +
>>>>>> +FIXTURE_TEARDOWN(unix_sock)
>>>>>> +{
>>>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>>>> +               variant->socket_type == SOCK_SEQPACKET)
>>>>>> +               close(self->child);
>>>>>> +
>>>>>> +       close(self->client);
>>>>>> +       close(self->server);
>>>>>> +       remove_socket_file();
>>>>>> +}
>>>>>> +
>>>>>> +/* Test 1: peer closes normally */
>>>>>> +TEST_F(unix_sock, eof)
>>>>>> +{
>>>>>> +       char buf[16] = {};
>>>>>> +       ssize_t n;
>>>>>> +
>>>>>> +       /* Peer closes normally */
>>>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>>>> +               variant->socket_type == SOCK_SEQPACKET)
>>>>>> +               close(self->child);
>>>>>> +       else
>>>>>> +               close(self->server);
>>>>>> +
>>>>>> +       n = recv(self->client, buf, sizeof(buf), 0);
>>>>>> +       TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
>>>>> errno is undefined if not set, and same for strerror(errno).
>>>>>
>>>>> Also, if ASSERT_XXX() below fails, the same information
>>>>> (test case, errno) is logged.  So, TH_LOG() seems unnecessary.
>>>>>
>>>>> Maybe try modifying the condition below and see how the
>>>>> assertion is logged.
>>>> Oh..thank you. Didn't it through that way.
>>>> I understand.
>>>> I will remove the TH_LOG()'s
>>>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>>>> +               variant->socket_type == SOCK_SEQPACKET) {
>>>>>> +               ASSERT_EQ(0, n);
>>>>>> +       } else {
>>>>>> +               ASSERT_EQ(-1, n);
>>>>>> +               ASSERT_EQ(EAGAIN, errno);
>>>>>> +       }
>>>>>> +}
>>>>>> +
>>>>>> +/* Test 2: peer closes with unread data */
>>>>>> +TEST_F(unix_sock, reset_unread)
>>>>>> +{
>>>>>> +       char buf[16] = {};
>>>>>> +       ssize_t n;
>>>>>> +
>>>>>> +       /* Send data that will remain unread by client */
>>>>>> +       send(self->client, "hello", 5, 0);
>>>>>> +       close(self->child);
>>>>>> +
>>>>>> +       n = recv(self->client, buf, sizeof(buf), 0);
>>>>>> +       TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
>>>>>> +       if (variant->socket_type == SOCK_STREAM ||
>>>>>> +               variant->socket_type == SOCK_SEQPACKET) {
>>>>>> +               ASSERT_EQ(-1, n);
>>>>>> +               ASSERT_EQ(ECONNRESET, errno);
>>>>>> +       } else {
>>>>>> +               ASSERT_EQ(-1, n);
>>>>>> +               ASSERT_EQ(EAGAIN, errno);
>>>>>> +       }
>>>>>> +}
>>>>>> +
>>>>>> +/* Test 3: SOCK_DGRAM peer close */
>>>>>> Now Test 2 and Test 3 look identical ;)
>>>> seems so, but the only difference is:
>>>>
>>>> close(self->child); is used in Test 2, while
>>>> close(self->server); is used in Test 3.
>>>> Maybe I should find a way to collapse Tests 2 and 3 (if statement might
>>>> work)
>>>>
>>>> I am just afraid the tests to run will reduce to 6 from 9 and we will have 6
>>>> cases passed as against 7 as before.
>>>>
>>>> What do you think?
>>> The name of Test 2 is a bit confusing, which is not true
>>> for SOCK_DGRAM.  So, I'd use "if" to change which fd
>>> to close() depending on the socket type.
>>>
>>> Also, close(self->server) does nothing for SOCK_STREAM
>>> and SOCK_SEQPACKET after accept().  Rather, that close()
>>> should have the same effect if self->child is not accept()ed.
>>> (In this case, Skip() for SOCK_DGRAM makes sense)
>>>
>>> I think covering that scenario would be nicer.
>>>
>>> If interested, you can check the test coverage with this patch.
>>> https://lore.kernel.org/linux-kselftest/20251028024339.2028774-1-kuniyu@google.com/
>>>
>>> Thanks!
>> Thank you!
>>
>> kindly check these if any conforms to what it should be:
>>
>> TEST_F(unix_sock, reset_unread_behavior)
>> {
>>           char buf[16] = {};
>>           ssize_t n;
>>
>>           /* Send data that will remain unread by client */
>>           send(self->client, "hello", 5, 0);
>>
>>           if (variant->socket_type == SOCK_DGRAM) {
>>                   close(self->server);
>>           }
>>           else {
>>                   if (!self->child)
>>                           SKIP(return);
>>
>>                   close(self->child);
>>           }
>>
>>           n = recv(self->client, buf, sizeof(buf), 0);
>>
>>           ASSERT_EQ(-1, n);
>>
>>           if (variant->socket_type == SOCK_STREAM ||
>>                   variant->socket_type == SOCK_SEQPACKET)
>>                   do { ASSERT_EQ(ECONNRESET, errno); } while (0);
>>           else
>>                   ASSERT_EQ(EAGAIN, errno);
>> }
>>
>> OR
>>
>> TEST_F(unix_sock, reset_unread_behavior)
>> {
>>           char buf[16] = {};
>>           ssize_t n;
>>
>>           /* Send data that will remain unread by client */
>>           send(self->client, "hello", 5, 0);
>>
>>           if (variant->socket_type == SOCK_DGRAM) {
>>                   close(self->server);
>>           }
>>           else {
>>                   if (self->child)
>>                       close(self->child);
>>                   else
>>                       close(self->server);
>>           }
>>
>>           n = recv(self->client, buf, sizeof(buf), 0);
>>
>>           ASSERT_EQ(-1, n);
>>
>>           if (variant->socket_type == SOCK_STREAM ||
>>                   variant->socket_type == SOCK_SEQPACKET)
>>                   do { ASSERT_EQ(ECONNRESET, errno); } while (0);
>>           else
>>                   ASSERT_EQ(EAGAIN, errno);
>> }
>>
>> OR
>>
>> is there a better way to handle this?
> Sorry for late!
>
> What I had in mind is to move accept() in FIXTURE_SETUP() to
> Test 1 & 2 (then, only listen() is conditional in FIXTURE_SETUP())
> and rewrite Test 3 to cover the last ECONNRESET case caused by
> close()ing un-accept()ed sockets:
>
> TEST_F(unix_sock, reset_closed_embryo)
> {
> 	if (variant->socket_type == SOCK_DGRAM)
> 		SKIP(return, "This test only applies to SOCK_STREAM and SOCK_SEQPACKET");
>
> 	close(self->server);
>
> 	n = recv(self->client, ...);
> 	ASSERT_EQ(-1, n);
> 	ASSERT_EQ(ECONNRESET, errno);
> }
>
>
>> I ran the KCOV_OUTPUT command using the first *TEST_F above* as the Test
>> 2 and got the output below:
>> *$ KCOV_OUTPUT=kcov KCOV_SLOTS=8192
>> ./tools/testing/selftests/net/af_unix/unix_connreset*
> You should be able to see line-by-line coverage by decoding
> files under kcov with addr2line or vock/report.py.
>
> Thanks!
>
So sorry for the late reply.
I have noted all and I will send v4 shortly
Thanks once again

