Return-Path: <netdev+bounces-271302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H80GWr7wmlXngQAu9opvQ
	(envelope-from <netdev+bounces-271302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:00:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1155331C9E7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 22:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0447304BDE7
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF060333441;
	Tue, 24 Mar 2026 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="WgoRQjgf"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D193825B30D;
	Tue, 24 Mar 2026 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774386022; cv=none; b=DVoWSThT5O83oTevk/W/PInW2cyRtwqIrXsnuj8igWssBo14MPWeB++eH0BxYc0Kz9eaqbMUI5rdkKqLQQNKmOTIlmbs8ZS7SSM4HOtYhFfT/iUsDg3u4JNmhAUf9XK8j8aWhLwu+4KeZZ8oRH71zc9XtxxKya/9r57GtbAGnBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774386022; c=relaxed/simple;
	bh=4IN37xQFXxyJwE0mRlTrwsVa85FzREeL3JCs1P/5Kvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVHFfAgeFsAeBPqApIXnyANr2lGh0g4EhKEauGa72+dkgDE3W+1Mu0w6R099IaBhZkHpcD4xb6+8K3eNpLQwDrF7t2Wg2MZIHsNkdbT2VMFt50ufwNJE3xaQkSeENLdnsmGPeW4TndGCWhT+UACfkXl8ODtA+VOR9K8wlDh3L0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=WgoRQjgf; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0D1AD40E0194;
	Tue, 24 Mar 2026 21:00:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6WDUFy_i4rik; Tue, 24 Mar 2026 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774386013; bh=BR3yEWx3FLoYnBT6ejXLArFk4bdNUVetIvOr0hEu9k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgoRQjgfKpnQbDxR9Wpwmo17AeReU718M/DWLRSRu3HFtJGYZM9VmpCjI7wGp4BrS
	 /GcfXQGYABROmPhMwG9Nhlwa9lbMnFG8o1xKNLNCU/6jn7nhmAvDTuTYMcqFCiPs3d
	 eoBKO4gflrvGeGOyUH7a64BmIl/WMYdHygf05x75+TS+LJgpcQao4vW/PFcvN8rQed
	 WT0bENJjIfzMSrI/AbeuFH+Qb5+kSUfSL5uhXlo/A/u4PUezCkyZI9eu+2gRg449Em
	 1XArikZYwp/xNnaIJJnMDFb6ZxQOzPKx8vdhNAZGclFsqhLlWF8VXQEt4Q8suQwiHh
	 97e6HdPKtKSXHZT7H/z3Uct3LlNouMirEtgTRqNiWWsxtWcvCq8U1ZIOflPBdhRgpU
	 DAHpeqnFKXK477/SZdZfTIJJlQxcvF1DXgVRi1vUcM6Qcc7y1owxBhGft9+bT0+vic
	 rP5CXqFYOM2xahKbewrYcJva6Mf+uRxePz0FYCzYklCs1I81ZeQ3k5qvFGfzHofHvY
	 EF8+sJKuIr1M58aEZBfxkp2F+LnU8jbQl/lylF5CHJMO4Z3ZzFTIqohZtl1OCmAT5q
	 Xt06+/tLQN6NPB1LUCGvi1d9DKioH1bHrMvPdGJaeBFGUxn+FxHUYEnLLA6wLwGRzo
	 4seepvY6T0obKAvWiLzyoWZw=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5F42540E0163;
	Tue, 24 Mar 2026 20:59:36 +0000 (UTC)
Date: Tue, 24 Mar 2026 21:59:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Laight <david.laight.linux@gmail.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
 <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271302-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,alien8.de:dkim,fat_crate.local:mid,suse.com:email]
X-Rspamd-Queue-Id: 1155331C9E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:16:51AM -0700, Pawan Gupta wrote:
> As a mitigation for BHI, clear_bhb_loop() executes branches that overwrites
> the Branch History Buffer (BHB). On Alder Lake and newer parts this
> sequence is not sufficient because it doesn't clear enough entries. This
> was not an issue because these CPUs have a hardware control (BHI_DIS_S)
> that mitigates BHI in kernel.
> 
> BHI variant of VMSCAPE requires isolating branch history between guests and
> userspace. Note that there is no equivalent hardware control for userspace.
> To effectively isolate branch history on newer CPUs, clear_bhb_loop()
> should execute sufficient number of branches to clear a larger BHB.
> 
> Dynamically set the loop count of clear_bhb_loop() such that it is
> effective on newer CPUs too. Use the hardware control enumeration
> X86_FEATURE_BHI_CTRL to select the appropriate loop count.
> 
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/entry/entry_64.S   | 21 ++++++++++++++++-----
>  arch/x86/net/bpf_jit_comp.c |  7 -------
>  2 files changed, 16 insertions(+), 12 deletions(-)

Ok, pls tell me why this below doesn't work?

The additional indirection makes even the BHB loop code simpler.

(I didn't pay too much attention to the labels, 2: is probably weird there).

---

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3a180a36ca0e..95c7ed9afbbe 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1532,11 +1532,13 @@ SYM_CODE_END(rewind_stack_and_make_dead)
  * Note, callers should use a speculation barrier like LFENCE immediately after
  * a call to this function to ensure BHB is cleared before indirect branches.
  */
-SYM_FUNC_START(clear_bhb_loop)
+SYM_FUNC_START(__clear_bhb_loop)
 	ANNOTATE_NOENDBR
 	push	%rbp
+	/* BPF caller may require %rax to be preserved */
+	push	%rax
 	mov	%rsp, %rbp
-	movl	$5, %ecx
+
 	ANNOTATE_INTRA_FUNCTION_CALL
 	call	1f
 	jmp	5f
@@ -1557,17 +1559,17 @@ SYM_FUNC_START(clear_bhb_loop)
 	 * but some Clang versions (e.g. 18) don't like this.
 	 */
 	.skip 32 - 18, 0xcc
-2:	movl	$5, %eax
+2:
 3:	jmp	4f
 	nop
-4:	sub	$1, %eax
+4:	sub	$1, %rsi
 	jnz	3b
-	sub	$1, %ecx
+	sub	$1, %rdi
 	jnz	1b
 .Lret2:	RET
 5:
+	pop	%rax
 	pop	%rbp
 	RET
-SYM_FUNC_END(clear_bhb_loop)
-EXPORT_SYMBOL_FOR_KVM(clear_bhb_loop)
-STACK_FRAME_NON_STANDARD(clear_bhb_loop)
+SYM_FUNC_END(__clear_bhb_loop)
+STACK_FRAME_NON_STANDARD(__clear_bhb_loop)
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 70b377fcbc1c..a9f406941e11 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -390,6 +390,7 @@ extern void write_ibpb(void);
 
 #ifdef CONFIG_X86_64
 extern void clear_bhb_loop(void);
+extern void __clear_bhb_loop(unsigned int a, unsigned int b);
 #endif
 
 extern void (*x86_return_thunk)(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 83f51cab0b1e..c41b0548cf2a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3735,3 +3735,11 @@ void __warn_thunk(void)
 {
 	WARN_ONCE(1, "Unpatched return thunk in use. This should not happen!\n");
 }
+
+void clear_bhb_loop(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_BHI_CTRL))
+		__clear_bhb_loop(12, 7);
+	else
+		__clear_bhb_loop(5, 5);
+}
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 63d6c9fa5e80..e2cceabb23e8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1614,11 +1614,6 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 	u8 *func;
 
 	if (cpu_feature_enabled(X86_FEATURE_CLEAR_BHB_LOOP)) {
-		/* The clearing sequence clobbers eax and ecx. */
-		EMIT1(0x50); /* push rax */
-		EMIT1(0x51); /* push rcx */
-		ip += 2;
-
 		func = (u8 *)clear_bhb_loop;
 		ip += x86_call_depth_emit_accounting(&prog, func, ip);
 
@@ -1626,8 +1621,6 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
 			return -EINVAL;
 		/* Don't speculate past this until BHB is cleared */
 		EMIT_LFENCE();
-		EMIT1(0x59); /* pop rcx */
-		EMIT1(0x58); /* pop rax */
 	}
 	/* Insert IBHF instruction */
 	if ((cpu_feature_enabled(X86_FEATURE_CLEAR_BHB_LOOP) &&

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

