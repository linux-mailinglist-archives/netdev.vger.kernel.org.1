Return-Path: <netdev+bounces-55338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A534680A6F0
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 16:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0311F214F2
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071D423766;
	Fri,  8 Dec 2023 15:10:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout2.r2.mail-out.ovh.net (smtpout2.r2.mail-out.ovh.net [54.36.141.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A493843
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 07:10:26 -0800 (PST)
Received: from ex4.mail.ovh.net (unknown [10.110.208.160])
	by mo511.mail-out.ovh.net (Postfix) with ESMTPS id 7180228C10;
	Fri,  8 Dec 2023 15:03:37 +0000 (UTC)
Received: from [192.168.1.130] (93.21.160.242) by DAG10EX1.indiv4.local
 (172.16.2.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 8 Dec
 2023 16:01:56 +0100
Message-ID: <7f656048-314b-4c04-bc2e-cd29ab649f8b@naccy.de>
Date: Fri, 8 Dec 2023 16:01:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 0/3] ss: pretty-printing BPF socket-local storage
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>, David Ahern <dsahern@gmail.com>, Martin KaFai
 Lau <martin.lau@kernel.org>
References: <20231128023058.53546-1-qde@naccy.de>
 <20231128144359.36108a3d@hermes.local>
Content-Language: en-US
From: Quentin Deslandes <qde@naccy.de>
In-Reply-To: <20231128144359.36108a3d@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAS9.indiv4.local (172.16.1.9) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 3479312189382586024
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttddvjeenucfhrhhomhepsfhuvghnthhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvghrnheptdfgveetgfetkeejvefhudeiueeufeeffeeitdffjeevudehveejveegffdvkeefnecukfhppeduvdejrddtrddtrddupdelfedrvddurdduiedtrddvgedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoqhguvgesnhgrtggthidruggvqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdpnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdgushgrhhgvrhhnsehgmhgrihhlrdgtohhmpdhmrghrthhinhdrlhgruheskhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehuddupdhmohguvgepshhmthhpohhuth

On 2023-11-28 23:43, Stephen Hemminger wrote:
> On Mon, 27 Nov 2023 18:30:55 -0800
> Quentin Deslandes <qde@naccy.de> wrote:
> 
>> BPF allows programs to store socket-specific data using
>> BPF_MAP_TYPE_SK_STORAGE maps. The data is attached to the socket itself,
>> and Martin added INET_DIAG_REQ_SK_BPF_STORAGES, so it can be fetched
>> using the INET_DIAG mechanism.
>>
>> Currently, ss doesn't request the socket-local data, this patch aims to
>> fix this.
>>
>> The first patch fixes a bug where the "Process" column would always be
>> printed on ss' output, even if --processes/-p is not used.
>>
>> Patch #2 requests the socket-local data for the requested map ID
>> (--bpf-map-id=) or all the maps (--bpf-maps). It then prints the map_id
>> in a dedicated column.
>>
>> Patch #3 uses libbpf and BTF to pretty print the map's content, like
>> `bpftool map dump` would do.
>>
>> While I think it makes sense for ss to provide the socket-local storage
>> content for the sockets, it's difficult to conciliate the column-based
>> output of ss and having readable socket-local data. Hence, the
>> socket-local data is printed in a readable fashion over multiple lines
>> under its socket statistics, independently of the column-based approach.
>>
>> Here is an example of ss' output with --bpf-maps:
>> [...]
>> ESTAB                  2960280             0 [...]
>>     map_id: 259 [
>>         (struct my_sk_storage) {
>>             .field_hh = (char)127,
>>             .<anon> = (union <anon>) {
>>                 .a = (int)0,
>>                 .b = (int)0,
>>             },
>>         },
>>     ]
>>
>> Quentin Deslandes (3):
>>   ss: prevent "Process" column from being printed unless requested
>>   ss: add support for BPF socket-local storage
>>   ss: pretty-print BPF socket-local storage
>>
>>  misc/ss.c | 822 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 818 insertions(+), 4 deletions(-)
> 
> 
> Useful, but ss is growing into a huge monolithic program and may need some
> refactoring. Also, this cries out for a json output format. Which ss doesn't
> have yet.

I've submitted a v2 to fix Martin's comments and also improve the printing
behavior. The updated revision reduces the number of lines added by 50%.

Regarding the JSON output, is it specifically for socket-local storage, or
more generally, for the whole tool? I agree with you anyway, but I would argue
that it doesn't fit this series, although I can work on this as a next step.

