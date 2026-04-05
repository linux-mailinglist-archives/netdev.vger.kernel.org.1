Return-Path: <netdev+bounces-275472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJLfAI6e0mnyZAcAu9opvQ
	(envelope-from <netdev+bounces-275472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 19:40:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 658BE39F3B3
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 19:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D50A3005667
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6132D780C;
	Sun,  5 Apr 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="nfpBeRk/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103412D5923
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775410827; cv=none; b=ojtQgSB7DStnQORo2VFy3x5cY/j3eMSVy9P2lMSIiUTySPWoalafdX9zvYGVchSWxHDAuMbFrzVIUiPhOfmyvUChSsxpu+EIzpkk+GSyw5NJqfWGBiaE6GQn09F7OaBoE6NUKhGcVOphNlERO60Y4+YOwn5kxuoGavF03UXLMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775410827; c=relaxed/simple;
	bh=Od8QmirE7EkLSxDA4qy4aAGMsJB+SnUA05UuMXwcpHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUUS/JyVEKzAgEgM02mTJdHvscwla8PjZNxWi4TKS4Zgy8BDqPfpZFy3wGOLzTBsRMvR0E4/cMKK5ovw7LjR8XNh716ekgRyvlB6DLC9llliK/UEcMXVnJxoNDVBv6Y8oL7ybVYggqeYHy0d4xQsBL2wVvwOq1D7BvmMn4Xewf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=nfpBeRk/; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso2918758eec.1
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1775410825; x=1776015625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zADj+v7r/QefwidmH66YAGAAPletG8mlfRYXnGJaQv0=;
        b=nfpBeRk/Ycifpdv+mshin5R8oZnmpb1S6CMCWq1XHSGkDlq+Zxv1koCb0fMUr2CL/B
         1M9AtmGNBUPFrlvEp21xlJvLel6DjPxOPzf4RtjHp8gPcOIUq9gY00gmMBrJHBcigik5
         i5mx1pbwlg7JpNJWYs2U12xWbMavWOaZaOpwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775410825; x=1776015625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zADj+v7r/QefwidmH66YAGAAPletG8mlfRYXnGJaQv0=;
        b=pcKmlwZ3BL95/qVvW1ezgmi43NSBhd7jdEI8N4qvgJxeH8fQO5dK87rFsg7wIUkRZL
         2iWTY77jbgFj1Mbvn3f3bHKQ7Xwo92Pjd0FdlGoPoZDkefTIEo8sjDO3uvbJzsABenR6
         rHCy10IXK+pYJAUdisDB7EnEPdnjRkVy8MunQKo9RpjI/zLi8ejUXofHhTmksPOh+Pb+
         9f2Esa5sESHNKM0dpHZYeIlV43Zjrb/D12tCmnQnxR0qBGSGjXvSUFw7Vo4gTHpyv1BT
         LswiAmeduB3xjCtL0eaeINt+e4Kp9TgjPV3HXxZhIPn4Bt8uvr4QbbXtHoAe6tHpzd0L
         N5sg==
X-Forwarded-Encrypted: i=1; AJvYcCXJcy+bwtQuAskzcqK22KKH2GeOKCfUl1l/Y4SwvljlSaqkKJ82dCF2KtX4E/vkzmJTGdhdMNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn2TCHhoPgW5QL5rGpajmimmczbxbvaCg+7vUfaokRLrM+qlCV
	erJTf9hfOT129WJTseLRXWNlNH57YWZz+Swvh8y+alIotJXHer5Hr5/nLh28lQ5M40E=
X-Gm-Gg: AeBDietTaZ8jjx9ffPC7EL9UrT4ZJDeSjn+2UEB/JSQCu9sfKWeoKXrzNP72MVJOWiY
	b60uf6qRch0lQMpT7gDAGtynmIWLR67lZwJ0AMobAbOBSIWTywPI1Z5uyeqz7b2bbo5XVHtcg05
	MVOasfSCGwkhXdiJlRJtTmGLrOoDZuspVn97QTX+THxYGbei5AhAFVAiOo88izfuZgVsxVgX942
	D+BCg91WW0SavtrfyIbBVYiIYvN7tD93rnWkXZYkoAcaaAOjuCzrAyToApDi40/BeXsGSg8M0jt
	G4Co5x2ZgCxBBsRaGDcF7cMgJxyfZf30sqkqSv/schehABaGLECsQ0SNMZJQqagKLnVCDDrGhWb
	lov5rG9mSOiksWErAkUnq3iAN2cqGDOt9sU0fWr7ur5W0kCAvQ8RfaosfvyIfqiY+lpfguU9Kpo
	ZitHj2j9mS5KEuR6zGACFWIsTwV11uMkkfhb4e
X-Received: by 2002:a05:7022:61f:b0:12a:6fb7:8801 with SMTP id a92af1059eb24-12bfb7074cfmr4464778c88.14.1775410824999;
        Sun, 05 Apr 2026 10:40:24 -0700 (PDT)
Received: from [192.168.1.2] ([179.105.152.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c05b7ffd4sm3990119c88.13.2026.04.05.10.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 10:40:24 -0700 (PDT)
Message-ID: <16f1456c-e540-4eca-a1c7-9d43a4b18539@allelesecurity.com>
Date: Sun, 5 Apr 2026 14:40:20 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rxrpc/proc: size address buffers for %pISpc output
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260404190004.4-rxrpc-proc-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Anderson Nascimento <anderson@allelesecurity.com>
In-Reply-To: <20260404190004.4-rxrpc-proc-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[allelesecurity.com,reject];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275472-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 658BE39F3B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/4/26 6:32 AM, Pengpeng Hou wrote:
> The AF_RXRPC procfs helpers format local and remote socket addresses into
> fixed 50-byte stack buffers with "%pISpc".
>
> That is too small for the longest IPv6-with-port form the formatter can
> produce: a compressed IPv6 address still permits a bracketed mapped-IPv4
> spelling plus the trailing port, which exceeds 50 bytes including the final
> NUL.
>
> Size the buffers from the formatters maximum textual form and switch the
> call sites to scnprintf().
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>   net/rxrpc/proc.c | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
> index 59292f7f9205..7925d4569776 100644
> --- a/net/rxrpc/proc.c
> +++ b/net/rxrpc/proc.c
> @@ -10,6 +10,10 @@
>   #include <net/af_rxrpc.h>
>   #include "ar-internal.h"
>   
> +#define RXRPC_PROC_ADDRBUF_SIZE \
> +	(sizeof("[xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:255.255.255.255]") + \
> +	 sizeof(":12345"))
> +
>   static const char *const rxrpc_conn_states[RXRPC_CONN__NR_STATES] = {
>   	[RXRPC_CONN_UNUSED]			= "Unused  ",
>   	[RXRPC_CONN_CLIENT_UNSECURED]		= "ClUnsec ",
> @@ -53,7 +57,7 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
>   	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
>   	enum rxrpc_call_state state;
>   	rxrpc_seq_t tx_bottom;
> -	char lbuff[50], rbuff[50];
> +	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
>   	long timeout = 0;
>   
>   	if (v == &rxnet->calls) {
> @@ -69,11 +73,11 @@ static int rxrpc_call_seq_show(struct seq_file *seq, void *v)
>   
>   	local = call->local;
>   	if (local)
> -		sprintf(lbuff, "%pISpc", &local->srx.transport);
> +		scnprintf(lbuff, sizeof(lbuff), "%pISpc", &local->srx.transport);
>   	else
>   		strcpy(lbuff, "no_local");
>   
> -	sprintf(rbuff, "%pISpc", &call->dest_srx.transport);
> +	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &call->dest_srx.transport);
>   
>   	state = rxrpc_call_state(call);
>   	if (state != RXRPC_CALL_SERVER_PREALLOC)
> @@ -142,7 +146,7 @@ static int rxrpc_connection_seq_show(struct seq_file *seq, void *v)
>   	struct rxrpc_connection *conn;
>   	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
>   	const char *state;
> -	char lbuff[50], rbuff[50];
> +	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
>   
>   	if (v == &rxnet->conn_proc_list) {
>   		seq_puts(seq,
> @@ -161,8 +165,8 @@ static int rxrpc_connection_seq_show(struct seq_file *seq, void *v)
>   		goto print;
>   	}
>   
> -	sprintf(lbuff, "%pISpc", &conn->local->srx.transport);
> -	sprintf(rbuff, "%pISpc", &conn->peer->srx.transport);
> +	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &conn->local->srx.transport);
> +	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &conn->peer->srx.transport);
>   print:
>   	state = rxrpc_is_conn_aborted(conn) ?
>   		rxrpc_call_completions[conn->completion] :
> @@ -228,7 +232,7 @@ static int rxrpc_bundle_seq_show(struct seq_file *seq, void *v)
>   {
>   	struct rxrpc_bundle *bundle;
>   	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
> -	char lbuff[50], rbuff[50];
> +	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
>   
>   	if (v == &rxnet->bundle_proc_list) {
>   		seq_puts(seq,
> @@ -242,8 +246,8 @@ static int rxrpc_bundle_seq_show(struct seq_file *seq, void *v)
>   
>   	bundle = list_entry(v, struct rxrpc_bundle, proc_link);
>   
> -	sprintf(lbuff, "%pISpc", &bundle->local->srx.transport);
> -	sprintf(rbuff, "%pISpc", &bundle->peer->srx.transport);
> +	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &bundle->local->srx.transport);
> +	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &bundle->peer->srx.transport);
>   	seq_printf(seq,
>   		   "UDP   %-47.47s %-47.47s %4x %3u %3d"
>   		   " %c%c%c %08x | %08x %08x %08x %08x %08x\n",
> @@ -279,7 +283,7 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
>   {
>   	struct rxrpc_peer *peer;
>   	time64_t now;
> -	char lbuff[50], rbuff[50];
> +	char lbuff[RXRPC_PROC_ADDRBUF_SIZE], rbuff[RXRPC_PROC_ADDRBUF_SIZE];
>   
>   	if (v == SEQ_START_TOKEN) {
>   		seq_puts(seq,
> @@ -290,9 +294,9 @@ static int rxrpc_peer_seq_show(struct seq_file *seq, void *v)
>   
>   	peer = list_entry(v, struct rxrpc_peer, hash_link);
>   
> -	sprintf(lbuff, "%pISpc", &peer->local->srx.transport);
> +	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &peer->local->srx.transport);
>   
> -	sprintf(rbuff, "%pISpc", &peer->srx.transport);
> +	scnprintf(rbuff, sizeof(rbuff), "%pISpc", &peer->srx.transport);
>   
>   	now = ktime_get_seconds();
>   	seq_printf(seq,
> @@ -401,7 +405,7 @@ const struct seq_operations rxrpc_peer_seq_ops = {
>   static int rxrpc_local_seq_show(struct seq_file *seq, void *v)
>   {
>   	struct rxrpc_local *local;
> -	char lbuff[50];
> +	char lbuff[RXRPC_PROC_ADDRBUF_SIZE];
>   
>   	if (v == SEQ_START_TOKEN) {
>   		seq_puts(seq,
> @@ -412,7 +416,7 @@ static int rxrpc_local_seq_show(struct seq_file *seq, void *v)
>   
>   	local = hlist_entry(v, struct rxrpc_local, link);
>   
> -	sprintf(lbuff, "%pISpc", &local->srx.transport);
> +	scnprintf(lbuff, sizeof(lbuff), "%pISpc", &local->srx.transport);
>   
>   	seq_printf(seq,
>   		   "UDP   %-47.47s %3u %3u %3u\n",

Do you have any evidence to confirm this issue? While the code could be 
improved, I don't see how that specific error would occur. Based on a 
quick experiment, the resulting string is at most 47 or 48 bytes (e.g., 
|[ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff]:65535|).

